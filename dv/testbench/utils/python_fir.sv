typedef real real_array[];

/**
 * Class: python_filter
 * Represent a generic filter. Inherit from here to create FIR or IIR.
 * It only provides the basic tools such as command execution and output reading/parsing
 */
class python_filter;
    real b[];
    string temp_file = "temp.txt";

    function new();
    endfunction : new

    virtual function string build_array_py(string name, real signal[]);
        string r;

        r = {name, " = "};
        r = {r, "["};
        foreach(signal[i]) begin
            string num;
            //num.realtoa(signal[i]);
            num = $sformatf("%.2f", signal[i]);   //convert string to real
            r = {r, num, ", "};
        end
        r = r.substr (0, r.len() - 3);  //remove last comma+space
        r = {r, "]"};

        return r;
    endfunction : build_array_py

    virtual function automatic real_array unbuild_array();
        integer fd;
        byte c;
        string temp;
        real q[$];
        real ret[];

        //read file
        fd = $fopen(temp_file, "r");
        if(!fd) $fatal();
        c = $fgetc(fd);  //discard first "["
        while(!$feof(fd)) begin
            c = $fgetc(fd);
            if(c == " ") begin
                    if(temp.len() > 0) begin
                    real r;

                    r = temp.atoreal();
                    q.push_back(r);
                end
                temp = "";
            end else begin
                temp = {temp, c};
            end
        end
        $fclose(fd);

        //convert from test to real array
        ret = new[q.size()];
        foreach(q[i]) ret[i] = q[i];

        return ret;
    endfunction : unbuild_array

    virtual function void delete_temp_files();
        $system({"rm -rf ", temp_file});
    endfunction : delete_temp_files

    virtual function string execute_py(string path);
        $system({"python ", path, " > ", temp_file});
        return read_temp_file();
    endfunction

    virtual function string read_temp_file();
        string ret;
        int code;
        int fd;

        fd = $fopen(temp_file, "r");
        code = $fread(ret, fd);
        $fclose(fd);

        return ret;
    endfunction
endclass : python_filter

/**
 * Class: python_fir
 * A FIR filter in python.
 * Pre-requisites:
 * |  pip3.12 install numpy
 * |  pip3.12 install scipy
 * Use:
 * |  python_fir fir = new();
 * |  y = fir.filter(.coefs('{0.5, 0.5}), .signal('{0.5, 0.5}));
 * You can compare with MATLAB:
 * |  filter([0.5, 0.5], 1, [0.5, 0.5])
 */
class python_fir extends python_filter;
    local string temp_file = "temp_fir.py";
    local real b[];
    local string py = "";
    local integer fd;

    function new(real coefs[] = '{});
        super.new();
        this.b = coefs;
    endfunction : new

    function automatic real_array filter(real coefs[] = '{}, real signal[]);
        string out;

        if(coefs != '{}) begin
            this.b = coefs;
        end

        build_py(signal);
        execute_py(temp_file);
        return unbuild_array();
    endfunction : filter

    local function void build_py(real signal[]);
        //build content
        build_header_py();
        build_body_py(signal);
        build_footer_py();

        //write file
        fd = $fopen(temp_file, "w");
        if(!fd) $fatal();
        $fwrite(fd, "%s", this.py);
        $fclose(fd);
    endfunction : build_py

    local function void build_header_py();
        py = "import numpy as np\n";
        py = {py, "from scipy.signal import lfilter\n"};
    endfunction : build_header_py

    local function void build_body_py(real signal[]);
        py = {py, "a = 1\n"};
        py = {py, build_array_py("b", this.b), "\n"};
        py = {py, build_array_py("x", signal), "\n"};
        py = {py, "y = lfilter(b, a, x)\n"};
    endfunction : build_body_py

    local function void build_footer_py();
        py = {py, "print(y)\n"};
    endfunction : build_footer_py

    virtual function void delete_temp_files();
        super.delete_temp_files();
        $system({"rm -rf ", this.temp_file});
    endfunction : delete_temp_files

endclass : python_fir
