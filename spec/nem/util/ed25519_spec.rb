require 'spec_helper'

describe Nem::Util::Ed25519 do
  subject { described_class }
  # from https://github.com/NemProject/nem-test-vectors
  [
    %w[575dbb3062267eff57c970a336ebbc8fbcfe12c5bd3ed7bc11eb0481d7704ced c5f54ba980fcbb657dbaaa42700539b207873e134d2375efeab5f1ab52f87844 NDD2CT6LQLIYQ56KIXI3ENTM6EK3D44P5JFXJ4R4],
    %w[5b0e3fa5d3b49a79022d7c1e121ba1cbbf4db5821f47ab8c708ef88defc29bfe 96eb2a145211b1b7ab5f0d4b14f8abc8d695c7aee31a3cfc2d4881313c68eea3 NABHFGE5ORQD3LE4O6B7JUFN47ECOFBFASC3SCAC],
    %w[738ba9bb9110aea8f15caa353aca5653b4bdfca1db9f34d0efed2ce1325aeeda 2d8425e4ca2d8926346c7a7ca39826acd881a8639e81bd68820409c6e30d142a NAVOZX4HDVOAR4W6K4WJHWPD3MOFU27DFHC7KZOZ],
    %w[e8bf9bc0f35c12d8c8bf94dd3a8b5b4034f1063948e3cc5304e55e31aa4b95a6 4feed486777ed38e44c489c7c4e93a830e4c4a907fa19a174e630ef0f6ed0409 NBZ6JK5YOCU6UPSSZ5D3G27UHAPHTY5HDQMGE6TT],
    %w[c325ea529674396db5675939e7988883d59a5fc17a28ca977e3ba85370232a83 83ee32e4e145024d29bca54f71fa335a98b3e68283f1a3099c4d4ae113b53e54 NCQW2P5DNZ5BBXQVGS367DQ4AHC3RXOEVGRCLY6V],
    %w[a811cb7a80a7227ae61f6da536534ee3c2744e3c7e4b85f3e0df3c6a9c5613df 6d34c04f3a0e42f0c3c6f50e475ae018cfa2f56df58c481ad4300424a6270cbb NA5IG3XFXZHIPJ5QLKX2FBJPEZYPMBPPK2ZRC3EH],
    %w[9c66de1ec77f4dfaaebdf9c8bc599ca7e8e6f0bc71390ffee2c9dd3f3619242a a8fefd72a3b833dc7c7ed7d57ed86906dac22f88f1f4331873eb2da3152a3e77 NAABHVFJDBM74XMJJ52R7QN2MTTG2ZUXPQS62QZ7],
    %w[c56bc16ecf727878c15e24f4ae68569600ac7b251218a44ef50ce54175776edc c92f761e6d83d20068fd46fe4bd5b97f4c6ba05d23180679b718d1f3e4fb066e NCLK3OLMHR3F2E3KSBUIZ4K5PNWUDN37MLSJBJZP],
    %w[9dd73599283882fa1561ddfc9be5830b5dd453c90465d3fe5eeb646a3606374e eaf16a4833e59370a04ccd5c63395058de34877b48c17174c71db5ed37b537ed ND3AHW4VTI5R5QE5V44KIGPRU5FBJ5AFUCJXOY5H],
    %w[d9639dc6f49dad02a42fd8c217f1b1b4f8ce31ccd770388b645e639c72ff24fa 0f74a2f537cd9c986df018994dde75bdeee05e35eb9fe27adf506ca8475064f7 NCTZ4YAP43ONK3UYTASQVNDMBO24ZHJE65F3QPYE],
    %w[efc1992cd50b70ca55ac12c07aa5d026a8b78ffe28a7dbffc9228b26e02c38c1 2ebff201255f6cf948c78f528658b99a7c13ac791942fa22d59af610558111f5 NDQ2TMCMXBSFPZQPE2YKH6XLC24HD6LUMN6Z4GIC],
    %w[143a815e92e43f3ed1a921ee48cd143931b88b7c3d8e1e981f743c2a5be3c5ba 419ed11d48730e4ae2c93f0ea4df853b8d578713a36dab227517cf965861af4e NA32IDDW2C53BDSBJNFL3Z6UU3J5CJZJMCZDXCF4],
    %w[bc1a082f5ac6fdd3a83ade211e5986ac0551bad6c7da96727ec744e5df963e2a a160e6f9112233a7ce94202ed7a4443e1dac444b5095f9fecbb965fba3f92cac NADUCEQLC3FTGB25GTA5HOUTB53CBVQNVOIP7NTJ],
    %w[4e47b4c6f4c7886e49ec109c61f4af5cfbb1637283218941d55a7f9fe1053f72 fbb91b16df828e21a9802980a44fc757c588bc1382a4cea429d6fa2ae0333f56 NBAF3BFLLPWH33MYE6VUPP5T6DQBZBKIDEQKZQOE],
    %w[efc4389da48ce49f85365cfa578c746530e9eac42db1b64ec346119b1becd347 2232f24dda0f2ded3ecd831210d4e8521a096b50cadd5a34f3f7083374e1ec12 NBOGTK2I2ATOGGD7ZFJHROG5MWL7XCKAUKSWIVSA],
    %w[bdba57c78ca7da16a3360efd13f06276284db8c40351de7fcd38ba0c35ac754d c334c6c0dad5aaa2a0d0fb4c6032cb6a0edd96bf61125b5ea9062d5a00ee0eee NCLERTEFYXKLK7RA4MVACEFMXMK3P7QMWTM7FBW2],
    %w[20694c1ec3c4a311bcdb29ed2edc428f6d4f9a4c429ad6a5bf3222084e35695f 518c4de412efa93de06a55947d11f697639443916ec8fcf04ebc3e6d17d0bd93 NB5V4BPIJHXVONO7UGMJDPFARMFA73BOBNOOYCOV],
    %w[e0d4f3760ac107b33c22c2cac24ab2f520b282684f5f66a4212ff95d926323ce b3d16f4ead9de67c290144da535a0ed2504b03c05e5f1ceb8c7863762f786857 NC4PBAO5TPCAVQKBVOC4F6DMZP3CFSQBU46PSKBD],
    %w[efa9afc617412093c9c7a7c211a5332dd556f941e1a88c494ec860608610eea2 7e7716e4cebceb731d6f1fd28676f34888e9a0000fcfa1471db1c616c2ddf559 NCFW2LPXIWLBWAQN2QVIWEOD7IVDO3HQBD2OU56K],
    %w[d98499b3db61944684ce06a91735af4e14105338473fcf6ebe2b0bcada3dfd21 114171230ad6f8522a000cdc73fbc5c733b30bb71f2b146ccbdf34499f79a810 NCUKWDY3J3THKQHAKOK5ALF6ANJQABZHCH7VN6DP],
    %w[6546cde23b18f4733a0a897960cb7f1021ad4b5afd4df58ae813829b0620bd5b 45805bbfdb19429a966594e9b9952103db3d2ba22f05d1c1a2e761076a5e01ed NCFYU27SUDN6CKMS5QTYJW4FG6T7M3VTZWYT73J5],
    %w[b9b05b3e8557db5a543b324f76439313463ad34856981f86061b8dfbffaca60c 259b1af615e30f99b9cd424ee0e18e24a2721560a9e02cd7a21ac13fbddc967e NDBESMFCE3VQ5JIBL2U2DZLOKB4EWSKMX357J72A],
    %w[140ce0a3aa32f5abf69169d6abe0bc321f2d5b0201fa1d85441788f71a142539 f2a4d7f476f3ee9a961cdef405dd7504b38d64d14c4e17b7ab71e71c8fb3b4e7 NCNRRYOUAVHXA2LZHJPONSPZQ36QYSSESUEVKJLO],
    %w[1ec774b1d9d0bdcb62fbc7d7417fbb5ecc1b9f8ee50f86ec51c2625900f20d99 3490d4f6c9aa283b67ae4a9b2e65346462237705d98433351febff457956d89f NDESTDJAZ42BQVFM7O7LITP22FE5Z7VR6FNU7BZ6],
    %w[0a5949c1fbb4b5f562870d53a73c1d22a28702881415e0604b04b3dd3c47ca4d ea3a5d45cb356e72771009253a385b6267bbdde1863cbcc687793508f5b659c3 NCLP3JRVI2S7LTZJYEUVUTWXI54QJ5ZBJLTFP3QN],
    %w[6b4fec346040ecb3ef696995ec9c5e9ab3c59726a92b628d9578b94c419a45ba f8d82b7c69c7b7fb7dbd3cc11591e6b0163e0f4c17644f3b935e0d8a096c7ce1 NDLGVZZU5V2VVEJ6BIZDQI6HYEPSMJ5LJFUF7U46],
    %w[032d5a1558209ef0462fba5e2126451e693c11b81c25006cf2fe57bad4097fa7 7faa6f65050c5ac97f6fd907555764232cf69307c123c0a197a8b8a2715fe8a9 NAOSK7KRU3XOD2UCBMTUIBXV4CSPRLKY756UMG24],
    %w[c1d79ff8bf2f63fff573fa07ba00a4f7eb6b7aeaf35c33f9cff57d560669fd22 6726d4cfa270165ce4c10ca6ffa15035679889a976fe5925a58ed642ec90ad35 NBYB5MIVLX4YKD7TTSJMF2ZROJMAWVT64KUFU4VB],
    %w[6c643c1ee7837cd3abb1f3b9221b2dbf11c3735023688a92779fba3fe10da2f5 9f68bd343b565d2333ee1e507541411868c4d15727f6d7451e31f2fc20084268 NBADKGYLJAFLZ4GQE4RSKSCQZFBAV5TP7ARRQ3XO],
    %w[1aa7172480361b6dc9c918b61d71d78e656d36c18e8a1d4548bae8d9df990ed3 d556956e4ae43d4146335820819018c2f0723e4d5c03b18ffffa8fc1096b832d NCZRJTC75YILMUCCEPNHSLFLOGPMR3CQUJS2ZXFL],
    %w[ede40a056b57904a09e0623ee5aa69164fe01a5aa9caacd41d85afe1415da36d 06b4e42df71524d7ef443dec4eb95f701990799c796f695c2933f856465f8cb4 ND7JJ3NWV5JGMRA46MJLT7JO5K354YMVWG45CSP5],
    %w[b5b7f1a1abc6bec376a273454ab329d11dc883f1693d26d364396c3b6d839e5a 3bdefe140c710ae70ec227396cff553db8310dad36cdcfc6904fa02b917f75b9 NAN346HPWBUYNN7HFPPUJOPUSIC4F44QPLD26JQ6],
    %w[24cdb71e538f7479b69e25064e63d9ca2c0efccca0834bed8b6b8e71cf964212 a8b5be9454477cf3a8f811d27582e3dac210a44ae6f839f11849fa6db5a4b1b0 NABEJ57HBE27RU47EBR3CWPDSVOW3QI5J2EW4YYL],
    %w[c4ea973b09ed0b5a2727603da1311f56ca5c4e35666cbf4cf5ce7804e64e496f f25e35d046714a74079f60ea83c8011c746768a77e5d7cedf8edfec17379fbd5 NAWCD4PWVZQSXPXTRPC3MX5ODGGQ4GBTCSV4L5QY],
    %w[b0b6e2c275e4ebdb8ddb6a2bdd19ceb5715a1a97875b87fca58653e926a3061d 66d5ee2f7a9a29cc9f17b9b89ef829311698af97cc76b3b480ee9e50bb3e666b NBB6U5PPRFMTG2Y4JIXLN75RM2XRX2GVHECVZVP2],
    %w[b7ea396441b4a76614deabd0327578a15a17ec96931f3e7205d5e0efa6323e37 2e6a2f37b6c1b30b3695e9019dffe12d41fcb94937c41a91009230e6aac8a387 NADZTPHU4NOR4RDM2TTRDGJ3CMSP7WX7SX5XGJLW],
    %w[8a4e4d1976a24460f332c271ae211313cb5a2949f7855fb1035718f843ac17d0 8b69d79f0f4b8d990ee1bc0a748d6257445a3f14c8be716375a6770d510c2177 NAME6JRX3Y6DN2TPORXO5C7TLRFD7EH4ERGU25VT],
    %w[9028e57d3ffdecebb4df9a8872160d1549d2a305af21e37c5b29ea4a44cd7e1c 29f98a5cd53748837221aca6fcb0a81a3843db7c58543aa56771d0671701384d NDT7V4JBORZJITRIWJAWHLVQELKVHCEIEVFKA5YM],
    %w[32182ccaf4d6f9ab6e9524d4323d7ac2da9894912209bd0ee8ea9d6eefa5adeb 846781656ffff388fa0a3e269cc6fa47111c35f4239f7d3b31f4186cf3e685ac NB4BJOXS345QEQ6VPGTMMOXAIXJ3PL765HHSS3WJ],
    %w[70995dc1f22a3eaa65bd36ea5277d4eb51953b654a06cccd40ad76d62a3ed177 9d12d7e8aebcb5b051cc7a5e294dd1f155d41203ab9b49c16da7025cd07c8bff NAYSINTQORROCA2SL7Y4E7HYXDZC6UEV4SVQHOEQ]
  ].each do |k, v|
    context "#{k}" do
      describe '.publickey_hash_unsafe' do
        it {
          sec = k.scan(/../).map(&:hex).reverse.pack('C*')
          expect(subject.publickey_hash_unsafe(sec).unpack('H*').first).to eq v
        }
      end
    end
  end
end
