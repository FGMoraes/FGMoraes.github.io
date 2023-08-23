--++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
--	Grupo de Apoio ao Projeto de Hardware  - GAPH
--	Projeto X10GiGA - FINEP/PUCRS/TERACOM
--
--	M�dulo:	Mem�ria - Gerador de Frames - Prototipa��o
--	Autor:	Jeferson Camargo de Oliveira
--
-- 	FRAME:	0000
-- 	RAMB:	03
-- 	CONJ:	A
--
--	M�dulo gerado em 17 de July de 2008 �s 16h55min pelo
--	programa gerador de frames OTN do projeto X10GiGA.
--++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++

library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.std_logic_unsigned.all;

----Pragma translate_off
library unisim ;
use unisim.vcomponents.all ;
----Pragma translate_on

entity FRAME0000_A3 is
port(
		addr	: in  std_logic_vector(9 downto 0);	-- Barramento de endere�os da porta
		clk		: in  std_logic;					-- Entrada de clock para a porta
		dout	: out std_logic_vector(15 downto 0)	-- Sa�da de dados da porta
	);
end FRAME0000_A3;

architecture FRAME0000_A3 of FRAME0000_A3 is

	signal addrin	: std_logic_vector(9 downto 0);
	signal clkin	: std_logic;
	signal doutout	: std_logic_vector(15 downto 0);

	component RAMB16_S18 is
	generic(
		WRITE_MODE : string;
		INIT_00,INIT_01,INIT_02,INIT_03,INIT_04,INIT_05,INIT_06,INIT_07,
		INIT_08,INIT_09,INIT_0A,INIT_0B,INIT_0C,INIT_0D,INIT_0E,INIT_0F,
		INIT_10,INIT_11,INIT_12,INIT_13,INIT_14,INIT_15,INIT_16,INIT_17,
		INIT_18,INIT_19,INIT_1A,INIT_1B,INIT_1C,INIT_1D,INIT_1E,INIT_1F,
		INIT_20,INIT_21,INIT_22,INIT_23,INIT_24,INIT_25,INIT_26,INIT_27,
		INIT_28,INIT_29,INIT_2A,INIT_2B,INIT_2C,INIT_2D,INIT_2E,INIT_2F,
		INIT_30,INIT_31,INIT_32,INIT_33,INIT_34,INIT_35,INIT_36,INIT_37,
		INIT_38,INIT_39,INIT_3A,INIT_3B,INIT_3C,INIT_3D,INIT_3E,INIT_3F : bit_vector
	);
	port(
		DO   : out std_logic_vector(15 downto 0);	-- Port 16-bit Data Output
		DOP  : out std_logic_vector(1  downto 0);	-- Port 2-bit Parity Output
		ADDR : in  std_logic_vector(9  downto 0); 	-- Port 10-bit Address Input
		CLK  : in  std_logic;			 			-- Port Clock
		DI   : in  std_logic_vector(15 downto 0); 	-- Port 16-bit Data Input
		DIP  : in  std_logic_vector(1  downto 0); 	-- Port 2-bit parity Input
		EN   : in  std_logic;			 			-- Port RAM Enable Input
		SSR  : in  std_logic;			 			-- Port Synchronous Set/Reset Input
		WE   : in  std_logic			 			-- Port Write Enable Input
	);
	end component;

begin

	addrin <= addr;
	clkin  <= clk;
	dout   <= doutout;

	-- FRAME0000_RAMB03 instantiation
	FRAME0000_RAMB03 : RAMB16_S18
	generic map (

		-- The following generics are only necessary if you wish to change the default behavior.
		WRITE_MODE => "NO_CHANGE", 	-- WRITE_FIRST, READ_FIRST or NO_CHANGE

		-- The following generic INIT_xx declarations are only necessary
		-- if you wish to change the initial contents of the RAM to anything
		-- other than all zero's.
		INIT_00 => x"364C9096096A583869147608CBAD4AACCA105348EBE188949997DAA077E7FFFF",
		INIT_01 => x"BC77771E40A3DA930C624237F6BA3EAB59C11F2B2BC42B5B0330A8E54A7D3897",
		INIT_02 => x"9D091BF29450C45F7A751D0E3EFA3FA4094A5D7626BAD53126C3B624E5A1CA1A",
		INIT_03 => x"C784268803C5DF355467E8F5EDC33CB688DC1AC19F879CCCB641BBE3A234C5D6",
		INIT_04 => x"CB7B56ADAF2FB1755CEE320FE50E497D4195FCED064535ABEE2A5DA684A569E3",
		INIT_05 => x"B5E948256C7EC37248995241FA71901FD923D82B4D0A98BF1DD81B0DC9CA42C5",
		INIT_06 => x"B286BA5FCF6A079EE0DF0AEF1DDB3B5D7540524167505FF5174EA49B7BC6377C",
		INIT_07 => x"CE6B1B457FE4B942FEFD38A3E2A2859101E38F4CED05AA8323B56E8E3FBBEC79",
		INIT_08 => x"C355801370FED6A1D423C83617C9C63F543477F73A4FB23D6F74AC9D21A2DE01",
		INIT_09 => x"66A59F6A97EC9E0017A59CCB74E055068370F557CA4122932FEDEC452E50E660",
		INIT_0A => x"58FCE5C6BB9194B8F9AFD5224633A80DCBC46F200A1D6503E3DB44BF505B3C52",
		INIT_0B => x"221C38243EEC3E6E7356690A071E6F8EA6442EC7A315CFB279E3F33C590F3F93",
		INIT_0C => x"422FFDEFB3D064D334F89ED63229C49BD5F44901F604991F886D0A91AF4EB440",
		INIT_0D => x"AC11CFD33B216C664471C47B202843F36B35EBD4A5A4128AB0DF6E1CA73BA040",
		INIT_0E => x"F9EAA022B7F45B98141EECBCD124577A58F1A2E67CE9C800F37D7861B0774060",
		INIT_0F => x"4DB837E9AE4F10EA6DF737FBBF3DF0E802938016CAD4FEA31D62B05A8C98E90B",
		INIT_10 => x"CC42381420E2F546A108A5F06C6F8864B44AB2AABD94E13BF1D928C6B7412B08",
		INIT_11 => x"654F967A8A6CBA65DD86450B60BEB6EAA0E8491E151C421DCA616C98F89B32F4",
		INIT_12 => x"819FE8A4EE41071E105B18700BCC2B9EAD04D5877203E5C35D76424FCD7B0BF7",
		INIT_13 => x"A8483E8FA048961EE26736E2146ED29CF8B4530470486695155C4823AFE5FFD6",
		INIT_14 => x"C58AD4E3F7DA307D1225508575C667598EF8C51771C5C4C25437ED0494E249CC",
		INIT_15 => x"7217255158E283C79BEA835E4B29D96630C34D55523DD1C3DBABAFD8945A8006",
		INIT_16 => x"085E1A6418F9E0CAA8EF68C4A27167E16144DFC414BB227A3494D40D1454F3DD",
		INIT_17 => x"63C46343FA98CE7852DBC1C63F3CA1ED9AED3ABE721D481F4DAA32FAD59A694C",
		INIT_18 => x"3368091C66443EA30EB7101FAB6936555EB2F98CA79E853D4F841C0C1CDAC69A",
		INIT_19 => x"2B6E1910A7E5F0ED94D9B8D918BB6BFEA4E24823DAA60ADAC77DF77CD6099F40",
		INIT_1A => x"FA42DA78CAB4697DC16BC6CC25309A45108B03A6A70AFF4444BB17C45CBA8B82",
		INIT_1B => x"112228E79EDE2847681D47105CE63908AEF2984F1B14C552DC3FB688BAF1ECA5",
		INIT_1C => x"401D427BA04DA75CC73BFF696AF28F4D5E8425B228EB3AB4C39B1E3D0BF52678",
		INIT_1D => x"92789164359DFBA566904DAF92945F09F20712EDE96B5F7FA2C91317E9DF8FBA",
		INIT_1E => x"BEAB8C8E304F181B97377CD3CDD9B576D5945CFF5828DD9779EB67F762E69C1F",
		INIT_1F => x"CB7CFF4C4F4933A3B126FFDEB7217D06EE02592C283F7DC6FC6B19BE51D461B2",
		INIT_20 => x"04397CB4DE851EB4BE19AB80442814AC25A3B5B0CB4A83CF626057993374924E",
		INIT_21 => x"7CBE87CB972F1D7F24D7F92BDF8AF9772EE2A7038041A69C2DF83D3270C74661",
		INIT_22 => x"204E1D7A643FAFFB5894E58DE1A7F8CA0562933A3712D72A27335C77141FE9DA",
		INIT_23 => x"8255E3AC77E1ACCA6B53720BC832788F6D95F2D0E5B6E89CFF72504CA3C0F0B7",
		INIT_24 => x"39EA30F8CE60252D1D767526483A17075A71B6E4A042C114AD5DDF975A0CA709",
		INIT_25 => x"17B970E819BAD14AC96C1921E6EEAC8ACF31B4F4EE7E1B613BA1679FC84AE260",
		INIT_26 => x"95ABD51B882869F5C82FA8E11A62455B31EF6033C5C54296AD70318795059503",
		INIT_27 => x"FBDCF1411C7334BEE16777D5638D68C6863D6859674EE8AB180763A31A6A091E",
		INIT_28 => x"309EFFC2C29C9BDF65C82C1C1AE69B6002438EB047CE35AE15639BDF0DBFEE10",
		INIT_29 => x"EBD1252082D19A69F1544645D7D6BDFD9B609817FF073E17A99AE8DC0BB133F4",
		INIT_2A => x"037D2BC05B56774EEDA4747971872CDEB42C8AFE9E357E165D7587F2279820F1",
		INIT_2B => x"088FC88AB029777FBD3ED68C3D8677760490317E608B5971B55651C9D78D723F",
		INIT_2C => x"D57BA10BA1E53D0F97755BEA9879E330FC638B80C2A7368F47ABADBD578CD71C",
		INIT_2D => x"6F458BC4C2D4829C1950CC8AAE657B998A15705E6678F2F2C47266CE80C6451D",
		INIT_2E => x"47BF4169FD9312CE0A1D565F298CB24A6662051341E10FBE958F5CF1AF04B3A4",
		INIT_2F => x"A819E8B1EEA1544A4D8B8115A3A1B2902FCA6AE25E46D13B83449C773CC508A8",
		INIT_30 => x"7655258FA7881A113CD5EA5D329D53084D0F990EF56E8E596FEF672A13A7EDE2",
		INIT_31 => x"2DCA2BCFCC398346D3762EB95F2E44B3F8B19675AE28CBEF554054AF9D10D687",
		INIT_32 => x"F2518B43520995B95A3C01A4C22B4C9CD5DC993CDF9665C6A9477001C954E054",
		INIT_33 => x"3F66442B4CC80E84378E398A2A865815464D6F715478DE17E7006F513AD39B3B",
		INIT_34 => x"56458383E861E5727BE845E3F6CD1E75EF0D4A978FF430C73B878F96C1412CBE",
		INIT_35 => x"77D4A4DCF27F5B9CF20398D569A928E2584683C5A1E771D2059DE7CCD676EAAD",
		INIT_36 => x"5150A2B26DA2A525D1C694A27598D8DAADC150269A937BF80CAE5889829DBD59",
		INIT_37 => x"D5C1257367CE821FE3B9612218F215693E66E83CE93C9CCF40BA442F163120F1",
		INIT_38 => x"FA1FC7105907B88B14B79538F88306D82891E4B4AA7F4BA9DA40F8E7FC067AAE",
		INIT_39 => x"22FF367615A3B90DCF9E38A56C20EE066F43F9AEF6146C6038F371DF10D3D666",
		INIT_3A => x"7BACA0AA793A6C878DD3EFB30A468DAA7392F6B36265E81AB0DB508477D5B219",
		INIT_3B => x"19E4E0E37BFEDAE75C65DA9E67B0BB38B3837C1DB2FB4721DBEBC37BCD93E8EC",
		INIT_3C => x"9800CDB4DF7F1B6895B4B41D7FCE680027510FEA51FBE26ADE2651E296FDEA90",
		INIT_3D => x"BE8AE2A5FD8AB100D55DF0BCE7C239E4C78E1169E6E71A8A4516A4A85CC1D78A",
		INIT_3E => x"82EC14FDFFF79D33DAB535656E1BCC7A78935EE2DD5E4E666A6FEE26500E07ED",
		INIT_3F => x"1183D28BEF183AC199163B992035E195DDB446DB67F3C301DDCD98C3C0AFE4BF"
	)port map (
		DO   => doutout,			-- Port 16-bit Data Output
		DOP  => open,				-- Port 2-bit Parity Output
		ADDR => addrin,				-- Port 10-bit Address Input
		CLK  => clkin, 				-- Port Clock
		DI   => (others => '0'),	-- Port 16-bit Data Input
		DIP  => (others => '0'),	-- Port 2-bit parity Input
		EN   => '1',				-- Port RAM Enable Input
		SSR  => '0',				-- Port Synchronous Set/Reset Input
		WE   => '0'					-- Port Write Enable Input
	);
	-- End of FRAME0000_RAMB03 instantiation

end FRAME0000_A3;