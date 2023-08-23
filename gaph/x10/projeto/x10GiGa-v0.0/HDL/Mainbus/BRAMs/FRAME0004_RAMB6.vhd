--++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
--	Grupo de Apoio ao Projeto de Hardware  - GAPH
--	Projeto X10GiGA - FINEP/PUCRS/TERACOM
--
--	M�dulo:	Mem�ria - Gerador de Frames - Prototipa��o
--	Autor:	Jeferson Camargo de Oliveira
--
-- 	FRAME:	0004
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

entity FRAME0004_B1 is
port(
		addr	: in  std_logic_vector(9 downto 0);	-- Barramento de endere�os da porta
		clk		: in  std_logic;					-- Entrada de clock para a porta
		dout	: out std_logic_vector(15 downto 0)	-- Sa�da de dados da porta
	);
end FRAME0004_B1;

architecture FRAME0004_B1 of FRAME0004_B1 is

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

	-- FRAME0004_RAMB05 instantiation
	FRAME0004_RAMB05 : RAMB16_S18
	generic map (

		-- The following generics are only necessary if you wish to change the default behavior.
		WRITE_MODE => "NO_CHANGE", 	-- WRITE_FIRST, READ_FIRST or NO_CHANGE

		-- The following generic INIT_xx declarations are only necessary
		-- if you wish to change the initial contents of the RAM to anything
		-- other than all zero's.
		INIT_00 => x"A2B23F41685E17FF55FAE3CDEEE81D7E5DD6772829C0D04BB5A2CB67B78844E0",
		INIT_01 => x"859406DD3586B021C227DADE520D280878D10A20E6CC60F1C8590BA1C4C45523",
		INIT_02 => x"86B436E7DA9F9F602B6035454B58F38E93DE71FD72C208A9ECA45B34930BDC9C",
		INIT_03 => x"B4C0850950256508BAC2053FC1F64039166546D85F6CF0B77D2628D3998AF7BB",
		INIT_04 => x"8C232C922F031BD0FAC2D936D280B20096217B91FA28940C2DC44068BAD720A8",
		INIT_05 => x"7015526E325FAD894248B32669918E79246CC60A236DD2719C3AEB37FB6F298C",
		INIT_06 => x"288562C15094A68D4CE234B8CE0F50C27129A5E83E6FEE115363C53CE093A585",
		INIT_07 => x"CB23638B0893539AFA3F7B851EE0AE3948DE8EE904672CC00B3AF3372F7C414C",
		INIT_08 => x"3E907BB8331405A4B54DB0F341E2FC6364F560BA82A4E7C63F84CD6472FF7880",
		INIT_09 => x"309D3A58CFF5DE5411D03ED92543C2FF100A88F40B34972AFD18BBE5F6E3F6F1",
		INIT_0A => x"7855ADF01ADEF1C733EA5E4672E3B533FD0642D590DFE6C917F2630379505D19",
		INIT_0B => x"C4EAF8EF7D5C99FE2D31F539A1B1E6F904FFAA9F7D4121DB86E3EF504E121B1B",
		INIT_0C => x"33CD1AEFE451581EC3F027631C875C978E3C5DF4EED042EEB2406CC0B00E5C1D",
		INIT_0D => x"446AF5C4D3728D9E9B7C6133A0E96981E3860876F12324636DD7A646AF0F18F5",
		INIT_0E => x"F3C1926F353E7CDD6BA1C8523FC060EDCB76F4B97EFE92C31693B551EBB1434E",
		INIT_0F => x"45EE45F40C86AFD2B0D3BB6307047AAD2E5B36F5429272E70487E1008C00F8A2",
		INIT_10 => x"0AA482F4345586B139756316878A0CF08896EBB5732D7C061368B940C47C8F97",
		INIT_11 => x"5EAD7FF5AD963D7E569278D3D6E5C57228ED00A0F7482F14A466B4B8A2A19B08",
		INIT_12 => x"00AC349E1387F31447AB102A1DB6D7C6AFB024E65FAC83F0369724614D52358C",
		INIT_13 => x"07BCCD9E86DC7685B1C42DB7BD78FE8469EF390BC7F03D0F5F0CA1BE04DE2785",
		INIT_14 => x"735AA345D9533FBF5797E0194ABE94F7F92D30BB2A3BF33233E3DED2B58E860C",
		INIT_15 => x"58602CF11BAB83D7F41E93C39FF43B8E078ACE19F4E064A5061C1C1747855593",
		INIT_16 => x"56EC94B24B382886186AEEB55E50099A47F24840CFC970618520DF79AD485B7B",
		INIT_17 => x"AA45A004A617C0098269F428F60821F9C8CA1ECDC8A8C4DF68389C9A97EBEBE4",
		INIT_18 => x"83FA2D8D8AC42B934A56B29C7C19395855D717ED3EE8D18EC9C61B466455FD93",
		INIT_19 => x"E16E5A95C856642DEE2A1FF46996A02075AC637EDD05C99F79410F01AED42FF9",
		INIT_1A => x"8EB09F2D8A8EA917DC53DE0D1BD73DB3A27A5E2EA751B682B2F435610C9F8FB6",
		INIT_1B => x"8AAE66BE75C82B5AD0FBBAD2FA3F694D2C2807B1C589C3D339EFEA991F65EECB",
		INIT_1C => x"625A93BA5C30B8E96BCD92A67A4CBE1223D387B3B5146F1A82991C789B00C60A",
		INIT_1D => x"7DEAE44EBEF9D1E6646AE8240192DB0B453E02358446EAA317DE6534F074BC17",
		INIT_1E => x"3659D662D6EBA9DCEEC11C47A5229528412B1B890E6C90CDE7C989F7139CF196",
		INIT_1F => x"B94FF7ED54FDE383AEB0E7FF26EB7A8385F0EA5992311406AF41B289F9356F2D",
		INIT_20 => x"28A46EDA91F4E4CC49BB2C50C472E51503905912F10B349ECECE39DA0D6EC383",
		INIT_21 => x"E2678E9E8A581635857B586BBDFEE10254203AC7782CACBC9A3FDCB59A042562",
		INIT_22 => x"F9E471403EA99167E99851B78BD6DD66B3BF9A4294C07544CAA67A33955F698E",
		INIT_23 => x"491F741B842ABEFDAF8AD5B92AF92E2B3E68229EFE5C13611F76D33200BAD257",
		INIT_24 => x"BBF442EF389D0FA5686A7A5A669F0BE05A131875D3F65CA56E59ADC701E36C5A",
		INIT_25 => x"E043B8F315AD1E0AA73F2D384C9BAB2F9C58BB42B648BC3741608F056577A632",
		INIT_26 => x"BB43ABEFE0FE10A741E45C0CD44C0DE4FFADBFC46A708E22FBEB3232670C9406",
		INIT_27 => x"7331049792C32F95DA18516492F0488CA4530E89702EC2BC3F83F0B5F9FAF8A1",
		INIT_28 => x"20D5E5749B56A148B5D3D06D83636DFAF9BF152E1E25545B9114CF07266E2993",
		INIT_29 => x"3517D1B68718356652A134701E493456D6B59392B8282A168EB9926E720339F7",
		INIT_2A => x"4745AC4AFE259757D98AE645CF937B9AE34AB359A98577431A0263BF9EEE5656",
		INIT_2B => x"5B404BCA7EBF6ADDD5E9151FA68C6EB2E790E064AC8B29C6AA6E6C9070ECB937",
		INIT_2C => x"8D849A2F747700CB5E363D6A426962972565CFE839A45A78533E9A05E827DC23",
		INIT_2D => x"2D8787E43729788FD4116160EF87E71799C5777EB97F75BA08B0E7320C3488D9",
		INIT_2E => x"0C552F623CE743AC3AA36703B67541EBD7DB1D07EB2A51119129542C09D65C5B",
		INIT_2F => x"F24D01050A88E974902CAB86B10D0461453ACDB9E24C1A2ACCD47D4E16C56A73",
		INIT_30 => x"EB71167F494C41AC9B6B3CBDD4A3BB977899F677BEE26917B5D7EE4A55C72C30",
		INIT_31 => x"4E15771BD1F46822692787AC91E15014E3B2F458C634EA5530295E131549664A",
		INIT_32 => x"810579F33382D5FA0D7916DDC4AF1718DD3A0845A57CA1AA68350BD116517F24",
		INIT_33 => x"55A37837065245C13518CF309FBF25E0F688DD4D32A99004B76A171CF2ADB3DE",
		INIT_34 => x"23A62507259C116E835906E852888235563469999F713D5FCAF835A037C9A8BF",
		INIT_35 => x"5C3B381EB419EB19BA87F3A033B4EF076BA15545ECBB77C7C34AA8504E0318DE",
		INIT_36 => x"C077209422D7FE1B6A2E4827962F8FC2095F0DAB69BEA899379F3D54E95D91D3",
		INIT_37 => x"B13ECD55E373C5AEAE6DB3C70960D1EAF62EB49FC4FDE1CBCD7F2869A383D0BD",
		INIT_38 => x"DAA2D6FC296F0D70974F38BA9B71F768151FBB94ED87E36FFC9103481316990F",
		INIT_39 => x"36D22551C66848A161551420EBEF90D0AC71F7E5983CC1274F6B53B518D7D92F",
		INIT_3A => x"57FBC6B0D56F5A2679643DEECF8D1AEE5FD35134A7F9C9E3B89D33F32FD682D8",
		INIT_3B => x"93BEAAF5C91939484F780EEDD4F3D8F02B3609F2C1E018CE0C9547CA1220A1EA",
		INIT_3C => x"BBC88637ABAECCF22174D178069435122A42D9F8ECD8C682E5270ED66C2B8763",
		INIT_3D => x"EB193F5E6052C4FBEB11AE75EC7758F5CCECC4F08F0D8010AF8ACD272633305B",
		INIT_3E => x"4480EC830CC7CC099EBF15A519971236D678BC42A477D5D3F8D39BE1DE18911D",
		INIT_3F => x"11111111111111111111111111111111C5FCB844C69E3DC302B64675190671E8"
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
	-- End of FRAME0004_RAMB05 instantiation

end FRAME0004_B1;