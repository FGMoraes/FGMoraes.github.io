--++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
--	Grupo de Apoio ao Projeto de Hardware  - GAPH
--	Projeto X10GiGA - FINEP/PUCRS/TERACOM
--
--	M�dulo:	Mem�ria - Gerador de Frames - Prototipa��o
--	Autor:	Jeferson Camargo de Oliveira
--
-- 	FRAME:	0001
-- 	RAMB:	01
-- 	CONJ:	B
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

entity FRAME0001_B1 is
port(
		addr	: in  std_logic_vector(9 downto 0);	-- Barramento de endere�os da porta
		clk		: in  std_logic;					-- Entrada de clock para a porta
		dout	: out std_logic_vector(15 downto 0)	-- Sa�da de dados da porta
	);
end FRAME0001_B1;

architecture FRAME0001_B1 of FRAME0001_B1 is

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

	-- FRAME0001_RAMB05 instantiation
	FRAME0001_RAMB05 : RAMB16_S18
	generic map (

		-- The following generics are only necessary if you wish to change the default behavior.
		WRITE_MODE => "NO_CHANGE", 	-- WRITE_FIRST, READ_FIRST or NO_CHANGE

		-- The following generic INIT_xx declarations are only necessary
		-- if you wish to change the initial contents of the RAM to anything
		-- other than all zero's.
		INIT_00 => x"9244629E09883682875FD3FF7F3EFBA3653ACF98A6DDC8F1320BA6050172D02F",
		INIT_01 => x"DD30567ADA6006F0669765AD25A2C4F6B8E5B7CB592727BBB2E9A39E633116A3",
		INIT_02 => x"B358BFACF8ECF50F9345CA6BCFADA77B005DA7A700D6EC7D75A011D413411C5F",
		INIT_03 => x"C8DE35D976E76433FBB2A3BF02D93C929E9BA29C679D497B9F42E68E22F79F12",
		INIT_04 => x"90D255072508A09D868B12FC64CB903878BAEB2F0DAFAF20E5D1119E579CA538",
		INIT_05 => x"22FE7F55F0ED358E8ED4A38C1DE0F74084635DBCEFD0BDFD0A34D50BA17652B4",
		INIT_06 => x"34C65AEA5F0377D84AF3EC947F6CEC9DCDACEBCE3F8943AAC8D57420C1D6BB5D",
		INIT_07 => x"15180573D9A4682D91479671317E96BC41E60F87B08AC982F2F884966B133C18",
		INIT_08 => x"DE05C5A00A33FE67A3BDCC0621322438CE8C77F67866CC2FE71AAD7D3BF5FFF2",
		INIT_09 => x"880B56E37D324D76E9F68B4C1A8C5A9948BAFA32622B15BE0603F0DEF2AB0A2A",
		INIT_0A => x"69D3316F76558ED0870BC66A5A12452620CADBBDB58ABEA0FE748B9463CC637D",
		INIT_0B => x"FD8C944341A097EA27044BC85D807A883BBCAEEE583B6EB184EAB879A509270A",
		INIT_0C => x"FED1C8981C235E4696D1F3586D117B661DEDDABF049EA5F4C6B8D1EADDA948BE",
		INIT_0D => x"43A2489670706CC1A1CC551BD784A74425E8F31C73B3613BE2AC8399E6A439B3",
		INIT_0E => x"87E37A184DEB00F9C8763025DC620A795A1084B237E887689C968F12A04054BC",
		INIT_0F => x"2431D542A76A84101C97ACB6A2CD43D1A1883F3951546443929F268BD62FFF20",
		INIT_10 => x"78FB0CA0E400A0A30B9EB5F1705A5CB6014A4DBB4710D1AFA62A52B173441200",
		INIT_11 => x"E1FE783953D89A898D9F6EB018DE6ADAD5C3269D5C25AC7DB2D91452BA06E54B",
		INIT_12 => x"7306F033AD86F60F05F50F70E643B33AA5F76F0E4B84413673C8F4AB6AD87094",
		INIT_13 => x"19350B419928557ADCDA2AC6E08064460719BD601D7BDCF1C43DFD989E15B07D",
		INIT_14 => x"8AACE1E805BD1DC1A9677DB801B3F1A79291ABE0E313FB9CC29813C2F97824B2",
		INIT_15 => x"74E751AF2E4374F37326E5E72E1293C4F733B051725FFA40E89EB85DC01738B3",
		INIT_16 => x"C743EF7B59B74EA4141CC376F53BBA66311002265DFB81DC746D525F200C2357",
		INIT_17 => x"57A49A5CDED8368D4F937979AE2F0BF0008B71A0A4891366E605A42BBE27D9CF",
		INIT_18 => x"537CEAD2118D4BCA4F643E778A5FDE5FA28222D54FEE13B01FC985D47683B2AD",
		INIT_19 => x"4A9AD51917265AC00954B52016C2C57EB8C86D3BEA26C9A6BEBF874AAB780182",
		INIT_1A => x"40B4F324D4D87A5C220D42FB01FF838474E2FB7A5DD9B77ED2D4F25F97308DF5",
		INIT_1B => x"9A27711860123D75D2F73CC1E30C4A37702D4A7C6EBC82545AC84A5B55D197D0",
		INIT_1C => x"A596ADC76477A57C33DBEE6C50B6BE7951FD36368983445CAFFD48B8F7A0132E",
		INIT_1D => x"24926C0B1B425D485C57A7B938D31DAF698B2438A3EBC9924B92EF5B2CD1CC1F",
		INIT_1E => x"2AA80ABF8FA4C4C8E4FBBAA2FF9A0A2A15C95AA6CD295BD857F0861C33049E55",
		INIT_1F => x"E9E0FC88F4D321F0AEB0E7FF048FA157789976C70983A6B99144038373148CAA",
		INIT_20 => x"4A0DE3DBF3ABA04347F5233C1700AE4B099A8FAC574F47C34B01EB2F1D0E4BDF",
		INIT_21 => x"21BCE6469DD865F957ED8C3F7D094424414BDF1FDE69758ED4EF5F468A5A9406",
		INIT_22 => x"AF1FD812F12E18FCCFCBCC3AA654B7ED2230295CBBD8CC764D88CDF55AAE2215",
		INIT_23 => x"49FF01DFCB243B0A6026AB6A237BBB1869A3E0D252543216428698E95666B14F",
		INIT_24 => x"A98C907BB9589C2204D8639D1BD435200F5D4412A8B94B1250B7F6BAD4FF2762",
		INIT_25 => x"9F957198E7D31767AAB4FACEEB05E5ACBECE0C0EBE370BFDC80A172C1BC0FE17",
		INIT_26 => x"251036CF4FFDFACEBC17123F85B37100CA7E0B9B1FBF8747E132095D1450A074",
		INIT_27 => x"C7163B6CE7977A99590447EA6DE3D703F49B8624AE422DEDCC11985D10EDA36C",
		INIT_28 => x"AA08714FFAB934C9E5AA2D6379879A3D6B00CEA42F4B109B122126794E251E74",
		INIT_29 => x"B16F8716971A77AFAEE2E604064B016F009F481D703CAE579F8CFA6EE5F92950",
		INIT_2A => x"C4D9A173095A7B3A6B118D02A519B49FC7412AC0F32582DF8BF568FD87F9ED24",
		INIT_2B => x"37523B5709F6CD61AB5B735CDD5F2D6C789D5C7BA11AC7B81A4725CCADC552CF",
		INIT_2C => x"BC47E975504427804561FED7980ECEB5F3F6DC010EADAA991B3634C63DA727B0",
		INIT_2D => x"1425C4F83FD3FCA384D6AE87481E5FFEE351B1788C3EE191803CBA2DA2213AD6",
		INIT_2E => x"0B2BC5751A352AFDD8EB118BFC1AFB6661BF8D1133BC4D045602A265814E34C9",
		INIT_2F => x"16DE1F76EE2574B84E0E148F4EC4E6120AAB474B4BCEDA6D97581AA9C336046E",
		INIT_30 => x"926EABCA0E09E87D42F698BDE745F04058DC644C62BD4CF7D336A3DC8BAD75A0",
		INIT_31 => x"C001F3A33A1F235A0D822A69D6D8D75A0B2C6A72749463346145FF00B467C636",
		INIT_32 => x"944F2EA90B54FF7D67FE4060A9731373B17C3B90ACEEB16DFE681AC64AB9DB53",
		INIT_33 => x"A0D413DEB60C11A6C95C462ED1E45E777D4CAB44BEFCD64F15C7DFF906C443E7",
		INIT_34 => x"D7FFC62BE3DF666CE11FE3DFE0BF608B60B511A8CD7B08F12CE48239D8407741",
		INIT_35 => x"C5AB64EDD6A07743B198DF2B730FCF50C0183472C13F43DEBBAD28F76830661A",
		INIT_36 => x"32435A2CF6C17882DE384FD16244456AC629E26D65130D8E4D5BA96BB297EEC9",
		INIT_37 => x"7C68A9D9726BEC28A46AC05AE7670F354505C2CC682EE1CD43FABBDD4DD8EB23",
		INIT_38 => x"E84179131818861091738492A941595FDD1F87B3510BD9CBA174F11FFCF1C45D",
		INIT_39 => x"73BFE5651D2B7A39395855B63A4B0BF6A919A2C18721EC9D129ADBC70942DBF1",
		INIT_3A => x"6B5D3BE74281D919C949744A9798767210A36531D4C0230189A2AF3EAEC25FE2",
		INIT_3B => x"83787FAD55801C7B6433068D73B6E70CF9480BA0EB683E8F354E51D1A3A277C6",
		INIT_3C => x"985500E7E2823A0D15D2C8CD6E671A138AA93CA51D957A7127397733000BFAC8",
		INIT_3D => x"C0722C0C5967AD902781FCAC84A4C14F7F0AF5145C70277910D58AA5E0B130C2",
		INIT_3E => x"700DBE4D5EFF5DA80E62B5C93EAE998B801D7722FED1F62A43535A3A942F0F6B",
		INIT_3F => x"1111111111111111111111111111111133DF3B45E05B71A4DFCBF5B41408AC10"
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
	-- End of FRAME0001_RAMB05 instantiation

end FRAME0001_B1;