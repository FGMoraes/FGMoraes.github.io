--++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
--	Grupo de Apoio ao Projeto de Hardware  - GAPH
--	Projeto X10GiGA - FINEP/PUCRS/TERACOM
--
--	M�dulo:	Mem�ria - Gerador de Frames - Prototipa��o
--	Autor:	Jeferson Camargo de Oliveira
--
-- 	FRAME:	0001
-- 	RAMB:	02
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

entity FRAME0001_B2 is
port(
		addr	: in  std_logic_vector(9 downto 0);	-- Barramento de endere�os da porta
		clk		: in  std_logic;					-- Entrada de clock para a porta
		dout	: out std_logic_vector(15 downto 0)	-- Sa�da de dados da porta
	);
end FRAME0001_B2;

architecture FRAME0001_B2 of FRAME0001_B2 is

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

	-- FRAME0001_RAMB06 instantiation
	FRAME0001_RAMB06 : RAMB16_S18
	generic map (

		-- The following generics are only necessary if you wish to change the default behavior.
		WRITE_MODE => "NO_CHANGE", 	-- WRITE_FIRST, READ_FIRST or NO_CHANGE

		-- The following generic INIT_xx declarations are only necessary
		-- if you wish to change the initial contents of the RAM to anything
		-- other than all zero's.
		INIT_00 => x"6E0E73A179923A7607CEAE13FB0C14A8BD40BAC60CF1A6BD3D3C61A560760FD0",
		INIT_01 => x"7E023C81E334F58A4C3A5725789153E27060CEF320726003F84B5073FA5D869A",
		INIT_02 => x"F0A1C2DF5D471B032A5A151CA491314B589407CD67C1D33C47DDF2AFA3712379",
		INIT_03 => x"5AC78C1D26F99765C1C2763C06A9879778CBE8006C6BBC6389A303EC31C970D4",
		INIT_04 => x"515FD6C7A06575A69CCB974888ED9FAF270AF7B65B79A6319D3718C6ED6735F9",
		INIT_05 => x"415E2D3CD33CBE88A1AFBB8304C83DD17EE966603E0F274E5AE6E77D36BAD936",
		INIT_06 => x"F22CFB8E818B102BD42A876A757F116C22957FC5DD4AC7CE209AA1E08C9D2397",
		INIT_07 => x"96288DD5E3A6B4D502A50AAAD6AF7FFC8E410B247B588A45DE2FC8A330479F54",
		INIT_08 => x"BA6506D26D7224972E6F85158AFDB0E26C3D3A8A1516AD83846B05CE69EEA896",
		INIT_09 => x"883007E228B8006EC8A531CC9600803CC0AB9D68A18269366ABBA45D21E636CC",
		INIT_0A => x"9A6D710E44A4721350A426DC2A118C8726E0FBC2A691ED0B1FCFD40EE01364D6",
		INIT_0B => x"0A675F693A76C0AFDA3124D9BE248BE37D21FDC87A80F644FA7EB461436D3BE5",
		INIT_0C => x"5ACA1E3DCB11DDC1CAE769C103B432B0C3B8705D74AC58A198F5FA7CF2A70C06",
		INIT_0D => x"C5A24A3ABDA713131BF6BD1D4170E3198F3CD1834556013451746A411713F8DA",
		INIT_0E => x"95275786FC2A942BDBFC4135E6196E2AD33C1CAE42F8589C11D3A9095FDD8217",
		INIT_0F => x"26EDEEFC61B484E39CABE1041596183E6D1BC8D9A2F3BA406A41FC1252782C2F",
		INIT_10 => x"4D9B89682F569B888CCF9EDD3C4480F8105668B75904B93538C4954F657F6DD2",
		INIT_11 => x"D54E1CF6AD1D74CEE686B4ED9E6EC63987D0E8BA532C77964BE31381E0F63EE4",
		INIT_12 => x"18F0DA2C16DD364CA16AF02E39FBB8F886267427828E522E7DFFC29569022659",
		INIT_13 => x"E77BAE68E427C1A622C1ED984ABC5577DE0B13B0EB28D1164896926ED26D3F4B",
		INIT_14 => x"D03C3C11965DA6721FEDFB029425CD83FA4AFFF9F24D134EB3D2357898CE2F61",
		INIT_15 => x"620BFCF3AF0CA037666A9BF8052615C2DE29816244DB7FE261B2A4D9F123C772",
		INIT_16 => x"0EEDC162AD4FF84F401B5C82932042E480EC4D976C8657C1778865D6C3A59C50",
		INIT_17 => x"83F7D147134E011EC8F76DAA25C3C23530B79317DA453C667C306C410414E8D3",
		INIT_18 => x"FF92FE396689BF47CD81053FA1E81ADCB1D18F637EE8BCC40EA0BD77FAD50832",
		INIT_19 => x"D5496BCDA072A276D1BB5E5A58A8F9E037388E8D80216ACFB65D5F29C94E312F",
		INIT_1A => x"44AA92017B88AEA48D94CF3BFF97B496E75F7F15733F2C220C1CB5E8E29452DE",
		INIT_1B => x"0BB9B056EDE0F492D9DF2ECD9F2206F992AFD6309CD97A42152B5588CF8E927C",
		INIT_1C => x"9073F0888749EE3D5F1BAD10629B773D0D0D538E700CDD78D834FCA673A68AB1",
		INIT_1D => x"3517E322E50F6E8B90301D2CEDBA10D50B0A7A59ABC61486D42A5451CF04B262",
		INIT_1E => x"4347A3DE34F208A46840BF01EC2BD415163E2BC75A0342E4E53257C3C096CE32",
		INIT_1F => x"5A3BDCB139E755AB72BFB4EE842F029EB69DAC63132A2A6420D5699F26C1F1F1",
		INIT_20 => x"0B315FEE02BE7FC554D7EFF71786594F817139913C001DA98379226D7D6A45F7",
		INIT_21 => x"C11F98A24DB688A0256A235E4C0687EF2F671D12CDC9D40D42AD71CC12DE9D78",
		INIT_22 => x"585E5C1C6A65444405AD9878836C8CD32B5DDDE112B150AF9D9B69C864BCA926",
		INIT_23 => x"CF2DB116EAF3CB148FC42524A1CD144179DDF66299D8B29A81FF2D85C5B55CE9",
		INIT_24 => x"E4F1E1A2B5227F3DB548612C80F520D2EE5D9C2567467D13CA8E72DB5230DCED",
		INIT_25 => x"9429B71948BCEAD788440B2EE1A27276B029D0A538EBB4926A9AE9DB5C77E007",
		INIT_26 => x"94CA4695E2B314245E6565D0D21B1BFA827E74AF1876C7D612C89B87DCBE535B",
		INIT_27 => x"083E9321CBE2622137E6593F184EB1368C3DD38189367CF885AFAD54BBBBF93E",
		INIT_28 => x"190E2B21134BAC9F0330A9FB1740E9C25A54F434D8145027AD271A52D51594A0",
		INIT_29 => x"98A31EE678B265B6A7EC7415B3711E8F8C397CB9AF0931FCEC8C2E534EEAC7A9",
		INIT_2A => x"6A5E735B455265F1107E11DDC762CCF334B4FDF88E6F432FC3EFB7F731E1F199",
		INIT_2B => x"B8183CE3420D2F94166B5C33E10E91B882DD7BE901E1F212146AE3CF81AA028D",
		INIT_2C => x"210E00A719E0B66E7CFC84A90F18B3FDF47E354962509A99C71DA70E94A0F602",
		INIT_2D => x"1D2407A284CD13F7CA7D7A412A8959EFE71AE8F385EBC960799F19920240BEE8",
		INIT_2E => x"77CC9F164709ACB13B2804755A606D35811E429743C7AA4AD3C5D48E89770783",
		INIT_2F => x"E3EC18391A902B3847B98E0227A9729296C9DAB8F6EC6E5A336DF1291EE4C7B3",
		INIT_30 => x"F762EEA6FE4E4CCC2BEFC9CFD7A11EF30039341566C1E68215C89ACE89229999",
		INIT_31 => x"B8EB1DBFE746F9835CBC26FD5469B1BC774BB17D592BC5502400E96E130FC02E",
		INIT_32 => x"73F35FDA21BD72A9A4019ED3A70BBC50BCB6025216D87D738217119BE09481F6",
		INIT_33 => x"A6787240AA12E9971F4056B0224112BA0B32EFDD46CA774210DF17EA0456B418",
		INIT_34 => x"73738599B681C1646066536D8BAFD19B44AD2921ABE9F661CD5B48C1B985491D",
		INIT_35 => x"EA0B97821C105C684DA08677AE3234E3D096FCFE574F211AEBAA73EC312A914E",
		INIT_36 => x"50713F1139E7B2034769C2DB88D7724B1E5854819DEA9C95D5C64ECF8E79977D",
		INIT_37 => x"5CE4A8E5CA5523FDA50F7DF645E8267A3920AC593BAE65A734894DE5CADE728E",
		INIT_38 => x"E4F1E853B90BEFDA1CDF05FC03A52AFCF17B73DF5C357CA464E3A6B9433A7DE1",
		INIT_39 => x"BE1B2D9E17370A4ABB309B90E6FF92CE20AE196E6438A0AA300DAA8ED688F551",
		INIT_3A => x"EE33A19C23302709D098232CD7019C8C8F4E8294D6BFC360F88DBC2ED836441D",
		INIT_3B => x"394096B4E841244EA0EC097BFC43E11827929EA920D71B9BE84A3CDABCE396F7",
		INIT_3C => x"D134C7B0D256AAFA95B25D2873767859B854EE128BB80582194D94E9CA54DE01",
		INIT_3D => x"F69003D64C0B5F7D5C17B51EC5E5AEC9652E546C12467732211DC1CCB0643E67",
		INIT_3E => x"08B512ABCD964DAAA1AEB304065AB8F144479FCB349AADFCFCB624BF699704E7",
		INIT_3F => x"1111111111111111111111111111111194BE17F617F016378BA2F2DA24246B91"
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
	-- End of FRAME0001_RAMB06 instantiation

end FRAME0001_B2;