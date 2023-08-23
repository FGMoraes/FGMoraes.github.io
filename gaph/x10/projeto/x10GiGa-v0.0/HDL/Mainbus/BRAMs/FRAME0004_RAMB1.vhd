--++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
--	Grupo de Apoio ao Projeto de Hardware  - GAPH
--	Projeto X10GiGA - FINEP/PUCRS/TERACOM
--
--	M�dulo:	Mem�ria - Gerador de Frames - Prototipa��o
--	Autor:	Jeferson Camargo de Oliveira
--
-- 	FRAME:	0004
-- 	RAMB:	00
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

entity FRAME0004_A0 is
port(
		addr	: in  std_logic_vector(9 downto 0);	-- Barramento de endere�os da porta
		clk		: in  std_logic;					-- Entrada de clock para a porta
		dout	: out std_logic_vector(15 downto 0)	-- Sa�da de dados da porta
	);
end FRAME0004_A0;

architecture FRAME0004_A0 of FRAME0004_A0 is

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

	-- FRAME0004_RAMB00 instantiation
	FRAME0004_RAMB00 : RAMB16_S18
	generic map (

		-- The following generics are only necessary if you wish to change the default behavior.
		WRITE_MODE => "NO_CHANGE", 	-- WRITE_FIRST, READ_FIRST or NO_CHANGE

		-- The following generic INIT_xx declarations are only necessary
		-- if you wish to change the initial contents of the RAM to anything
		-- other than all zero's.
		INIT_00 => x"EB2A57B966EE2C3AAC4BF0064235ACC02FC867A7023CC70B1071BB194E91F6F6",
		INIT_01 => x"D59EEB8BA37D461895960CB30601AF31C8D92F933BF256EC981C85EDFE627676",
		INIT_02 => x"06F11B31DD2447B2F922DBFABA9A7E3BB4514EF5A92708B2FE75DEBCFB98D6DD",
		INIT_03 => x"B75D81BB78870D9150D4B0CEF5FF59EE111AAB83CA04CBD2A0BC421C50C433B1",
		INIT_04 => x"DA0ACB55742EC3C39A51E38AFCED6289DFD9EFB37219D651C4364B89F687D375",
		INIT_05 => x"B0614CB21601A22D06F3B818ED90CD4A88F63E7D851ED21B3FE3592DE1272F8C",
		INIT_06 => x"E934B8FAF4CE16C4CF7E9FA4BEFD271841B7EA83336D6FC4069CE0F6E20F9F8D",
		INIT_07 => x"7B2E94BEBE00E312C11CEBDF1A5BB75DD08AB15898EE53BB25FA8CBE1D6CCDA4",
		INIT_08 => x"A04DDE83B4C798A0D6731E85EFE06256DAF743E018E65D62015AA0F896B23F5D",
		INIT_09 => x"F905D45F74C357C29F82CAA391B407ABCF2F433F4A2E77A6B9A14924B8C52E94",
		INIT_0A => x"F6E4E729EC938971B8CE6B9E0F81AD020C53141B39622BD5F3977D017CE8AC66",
		INIT_0B => x"C40FF8614A73C66EDB9B72F7A9649C61AF0E1F540749067B6CC3A5C2F01B1310",
		INIT_0C => x"BDE712986C66F978B82CD524E2DE418635B3932077E2A90A7B5053153CD0F82C",
		INIT_0D => x"9AEF92498B12940B3C661F76551554F52D7C8C514D0B95F57177CCA5EB0090EC",
		INIT_0E => x"CF2DBB1840A2DAFEC84D2168EE5A060AE39F8FED6338C7CE230D995E1756E78F",
		INIT_0F => x"C7DED2BC51818D71787BF03DB2D6BFBF2087190D825BC05F84873E6C09C50BA3",
		INIT_10 => x"B226D302B4D74BA88583B58E659E83C050248993DFC9FF7F86781E84CDC2E21B",
		INIT_11 => x"588301CF240A3B16AE719505982DF4E562A62A55678A442B9F72FB96194191D8",
		INIT_12 => x"88EECDC7955D4D32D661D54F81B1ED54EDFF013BC2AA2EBB656B43B06E15B859",
		INIT_13 => x"338A568FBEBCD3F7C02B19520925C6752CEA31BB529C83909977E9004EB1FE59",
		INIT_14 => x"822755454DFC3AFB7B7CA3E9C4C23D459D28C239D1B5BD6AC34B0496C2CC4E3F",
		INIT_15 => x"FE5B52FA0101DD8DC88270AC83D85651C0DB120F90AB85260CA757AF52CC1B55",
		INIT_16 => x"BAAD77610B05665F94F7A338639856FFADB1987FD93CE47D2FC0D57F3F0CF948",
		INIT_17 => x"69CEE2E64ED24FAE2933DE1E6BA6F985970A8E11125AEF3B5F41AEA46AD07F9D",
		INIT_18 => x"FBBB22795A9D00992D30829707CEF04F6C35F78F8DFF87F5BA4B3EA70D1404BC",
		INIT_19 => x"873D8318E7E859310796CC65C77F5CE05F62FD3A65F864F1267B697BF28499D4",
		INIT_1A => x"F0D7EC104BD0469A8D2AFB287B99137959DD7B3B34AAD3CADA03648CDED298ED",
		INIT_1B => x"F8843684606E9E15F14668F2ADF17EE951584C91425ABEC6452618DBBA5095CD",
		INIT_1C => x"F3B0993FFE512338DA9DB02C25C36C7BCF3DC83D85F77A6DB254F6E4FC4810ED",
		INIT_1D => x"4D9879D61B3A5F5BC6F82426F1D76D14FC6BD7C92BF5F99FE33C134F01A554FC",
		INIT_1E => x"D35AD4AE9F64C549BA09B08534AEAE430069D419FEAA6FA47D5EB838324F9910",
		INIT_1F => x"E3C3B557CED7FA1E52BE41A6C2526DFF11CB6A964EDB37CDF2F0D52CDB8AB579",
		INIT_20 => x"50E4D0DE8918A92702F17917CD9E339CC64B7C210579D7FE9E2F1C4B4AE20886",
		INIT_21 => x"069323A552B829EFEA68D1977531E825D9FE1E9D6A15586315C5B00E8367F37D",
		INIT_22 => x"5A6C9E1C0E7AEA8270958BE6FF82A1589A874A1F79578468882B8C894E1B308C",
		INIT_23 => x"82E37E2C67B4593A6E830A66019838421DFBDB659E72A646A4A0F1F3A63C375F",
		INIT_24 => x"12AB930F059C8E323B1E0878EE4EA75FCD2365471FE57259E89C88C9627A514C",
		INIT_25 => x"73B280D121A7918C93C1CEC3ABCC274932001408640D66943D1BCCDF5BC6CFF8",
		INIT_26 => x"AB95D20BF8E9BFC1B9209E505AC564185AD1E450007F410D9A217652A73C334D",
		INIT_27 => x"E81404B6CB86FDA360511E6A4D3638BAD3A7010CF3C272335B5C204FE87DF1CE",
		INIT_28 => x"52E008EA30E48166486DDB63C150DB3F540CA4478D725868EBCA6579529A98F5",
		INIT_29 => x"200FA4DEFE0D007BE11E08AD9890B5D5D187967CC907A5E7A320BF7208F0A114",
		INIT_2A => x"2D34CCD111E08B73756B9DFFE01F7072127B43C24DEE721C070A36C65320FAB9",
		INIT_2B => x"9D92B5B0CF7D0E48EB28861390610C81306F7314697650C932497C98BF075CAA",
		INIT_2C => x"C2D0B892B341A761E5FD386C7D40103D4131811FE20523F9B7C98F2225F287D4",
		INIT_2D => x"713673C42AFB873F2706842EA17994631539A7280FDDFA0E3EC638D1F2951B67",
		INIT_2E => x"FD521AF3B8C5FFF8F96E6D20FA577466A2F332A9BF514CC4361DCAA1329646D9",
		INIT_2F => x"64594B97C7BEB238FF2AB9E7206A4FC2A3822E1747C60AB8A217DA13FC0C76D6",
		INIT_30 => x"0893613AAAF96D79B427700F0E9CD9A5041768A1AE9F1FF66CEC7D8233954BD0",
		INIT_31 => x"EA1A9B638164B9A7A6BF5FFE843C50F1703D6A741C0EF6D9B9C1083AAFDDA097",
		INIT_32 => x"E328E5488C16FDCA41A1BE0012F280647F62EF734633F5640BBC0462FAE1CDBB",
		INIT_33 => x"16A661AD49DEBA32076C3ED1EEA9ED3673438EAA46CE8B297DB95D23C05B0A08",
		INIT_34 => x"81C09D58B18137C1CEF3FB30D09EE9CD0B21FB9E1388891CAA091D11E81989AF",
		INIT_35 => x"98A8A745AA79EC1F8C7C02E33C3FB0C5543396808FA8C77B7D0F423D1BB53143",
		INIT_36 => x"9EA10F09A299F27ADC5BD0463A58B1B4C1BD50F9E1CB17CE5D275B35BCA770DD",
		INIT_37 => x"D08A3EA72E77BF724489080F87915748AAB3EE19429117F15404A0A5C59F50C8",
		INIT_38 => x"7B9E58537B4C37DA4576A1C404889D581B47ADC4A8E97D7D57D7679FA790A82A",
		INIT_39 => x"EDE6096DF21AF9A7A9781B9FD8AAE1D890128E35C3F9017DD9813D0765BA3E17",
		INIT_3A => x"12C1F12B26B3CAE39DD7FA1654B5F822773B9C4C061CA47093FC59C29E74E4CF",
		INIT_3B => x"D1861A2D1A2DC6542883E3EAB2CB2AF7261BABAFDEAEE46CD38639FD4CA813F5",
		INIT_3C => x"B924D2F0F511BC68BC63C0717C59F72CFF3738B5392E51D2B77450C586B97CEB",
		INIT_3D => x"4711C143D6462B1C68C50AFD148CAF3B7A3067DFB3E00F4A58930A523763016C",
		INIT_3E => x"A76D12EF591A0363084F941A6EFDF6CE9155CE5FAF26BBA84EB7AA0264B78CBC",
		INIT_3F => x"6523FBD0ADB671425CC10D715B77119F3DAC7FD1C2EE04B73B952796FC47B423"
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
	-- End of FRAME0004_RAMB00 instantiation

end FRAME0004_A0;