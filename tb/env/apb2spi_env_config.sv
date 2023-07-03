`ifndef ENV_CONFIG
`define ENV_CONFIG

class apb2spi_env_config extends uvm_object;
    `uvm_object_utils(apb2spi_env_config)
    
    bit has_scoreboard;
    bit has_predictor;
    bit has_spi_agent;
    bit has_apb_agent;

    spi_agent_config spi_config;
    apb_agent_config apb_config;
             
    function new(string name = "apb2spi_env_config");
        super.new(name);
    endfunction    
    

endclass


`endif