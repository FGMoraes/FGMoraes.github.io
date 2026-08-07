##############################################################
##              Logical synthesis commands                  ##
## Modified  by Fernando Moraes - 13/maio/2025           ##
##############################################################

set_db hdl_search_path "../rtl"
set_db information_level 1 

set_db hdl_track_filename_row_col true
set_db hdl_array_naming_style %s_%d
set_db hdl_instance_array_naming_style %s_%d
set_db hdl_generate_index_style %s_%d
set_db hdl_bus_wire_naming_style %s_%d

set_db syn_generic_effort high
set_db syn_map_effort high
set_db syn_opt_effort high

#keep hierarchy
set_db auto_ungroup none


#===============================================================================
#  Load libraries
#===============================================================================
#Set liberty
set_db library "/soft64/design-kits/stm/28nm-cmos28fdsoi_25d/C28SOI_SC_12_CORE_LR@2.0@20130411.0/libs/C28SOI_SC_12_CORE_LR_ss28_0.90V_125C.lib \
                /soft64/design-kits/stm/28nm-cmos28fdsoi_25d/C28SOI_SC_12_PR_LR@2.0@20130412.0/libs/C28SOI_SC_12_PR_LR_tt28_1.00V_25C.lib \
                /soft64/design-kits/stm/28nm-cmos28fdsoi_25d/C28SOI_SC_12_CLK_LR@2.1@20130621.0/libs/C28SOI_SC_12_CLK_LR_tt28_1.00V_25C.lib"
             
#set LEF           
set_db lef_library "/soft64/design-kits/stm/28nm-cmos28fdsoi_25d/SiteDefKit_cmos28@1.4@20120720.0/LEF/sites.lef \
                    /soft64/design-kits/stm/28nm-cmos28fdsoi_25d/CadenceTechnoKit_cmos028FDSOI_6U1x_2U2x_2T8x_LB_LowPower@1.0.1@20121114.0/LEF/technology.12T.lef \
                    /soft64/design-kits/stm/28nm-cmos28fdsoi_25d/C28SOI_SC_12_CORE_LR@2.0@20130411.0/CADENCE/LEF/C28SOI_SC_12_CORE_LR_soc.lef \
                    /soft64/design-kits/stm/28nm-cmos28fdsoi_25d/C28SOI_SC_12_PR_LR@2.0@20130412.0/CADENCE/LEF/C28SOI_SC_12_PR_LR_soc.lef \
                    /soft64/design-kits/stm/28nm-cmos28fdsoi_25d/C28SOI_SC_12_CLK_LR@2.1@20130621.0/CADENCE/LEF/C28SOI_SC_12_CLK_LR_soc.lef"

#Set captable
set_db cap_table_file "/soft64/design-kits/stm/28nm-cmos28lp_42/CadenceTechnoKit_cmos028_6U1x_2U2x_2T8x_LB@4.2.1/CAP_TABLE/FuncRCmax.captable"

#Set PLE
set_db interconnect_mode ple
