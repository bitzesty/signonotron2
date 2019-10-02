class CreateAuthorityPermissionsForLicensing < ActiveRecord::Migration[5.1][5.0]
  def up
    create_permission("deni")
    create_permission("cefas")
    create_permission("veterinary-medicines-directorate")
    create_permission("ofsted")
    create_permission("ecmk-ltd")
    create_permission("northern-ireland-environment-agency")
    create_permission("care-commission")
    create_permission("belfast-health-and-social-care-trust")
    create_permission("rics")
    create_permission("faculty-of-advocates")
    create_permission("roads-service")
    create_permission("carb")
    create_permission("information-commissioner's-office")
    create_permission("construction-industry-council")
    create_permission("privy-council")
    create_permission("h&vca-ltd")
    create_permission("access-ni")
    create_permission("surveyors-ombudsman-service")
    create_permission("northern-health-and-social-care-trust")
    create_permission("aspd,-home-office")
    create_permission("marine-fisheries-agency")
    create_permission("association-of-taxation-technicians")
    create_permission("care-and-social-services-inspectorate-wales")
    create_permission("south-eastern-health-and-social-care-trust")
    create_permission("historic-scotland")
    create_permission("architects-registration-board")
    create_permission("bcms")
    create_permission("southern-health-and-social-care-trust")
    create_permission("civil-aviation-authority")
    create_permission("institute-of-legal-executives")
    create_permission("chartered-institute-of-taxation")
    create_permission("institute-of-actuaries")
    create_permission("solicitors-regulation-authority")
    create_permission("psni")
    create_permission("natural-england")
    create_permission("deti-ni")
    create_permission("ipa")
    create_permission("marine-scotland")
    create_permission("association-of-international-accountants")
    create_permission("scottish-environment-protection-agency")
    create_permission("ofqual")
    create_permission("cadw")
    create_permission("acca")
    create_permission("health-inspectorate-wales")
    create_permission("the-faculty-office")
    create_permission("northgate")
    create_permission("tenants-services-authority")
    create_permission("icas")
    create_permission("elmhurst")
    create_permission("royal-college-of-veterinary-surgeons")
    create_permission("cibse")
    create_permission("western-health-and-social-care-trust")
    create_permission("abe")
    create_permission("sqa")
    create_permission("bar-standards-board")
    create_permission("association-of-law-costs-draftsmen")
    create_permission("claims-management-regulation")
    create_permission("countryside-council-for-wales")
    create_permission("knauf")
    create_permission("scottish-natural-heritage")
    create_permission("care-quality-commission")
    create_permission("hmrc")
    create_permission("association-of-accounting-technicians")
    create_permission("institute-of-certified-bookkeepers")
    create_permission("northern-ireland-office")
    create_permission("cipfa")
    create_permission("scottish-housing-regulator")
    create_permission("animal-health")
    create_permission("gas-safe-register")
    create_permission("national-proficiency-tests-council")
    create_permission("driving-standards-agency")
    create_permission("vosa")
    create_permission("ofgem")
    create_permission("farriers-registration-council")
    create_permission("dcells")
    create_permission("dfpni")
    create_permission("bre")
    create_permission("dclg")
    create_permission("hse")
    create_permission("quidos")
    create_permission("food-standards-agency")
    create_permission("ciat")
    create_permission("scottish-building-standards")
    create_permission("napit")
    create_permission("ccea")
    create_permission("northern-ireland-court-service")
    create_permission("streetworks-qualification-register")
    create_permission("postcomm")
    create_permission("energy-institute")
    create_permission("department-for-culture,-arts-and-leisure,-northern-ireland")
    create_permission("dcms")
    create_permission("office-of-fair-trading")
    create_permission("national-energy-services-ltd")
    create_permission("council-for-licensed-conveyancers")
    create_permission("dvla")
    create_permission("companies-house")
    create_permission("law-society-of-northern-ireland")
    create_permission("northern-ireland-tourist-board")
    create_permission("rqia")
    create_permission("the-property-ombudsman-limited")
    create_permission("scottish-ministers")
    create_permission("besca")
    create_permission("icaew")
    create_permission("dard")
    create_permission("metropolitan-police")
    create_permission("law-society-of-scotland")
    create_permission("northern-ireland-housing-executive")
    create_permission("ofwat")
    create_permission("british-waterways-board")
    create_permission("dept-for-rural-affairs")
    create_permission("forestry-commission")
    create_permission("aala")
    create_permission("environment-agency")
    create_permission("niaur")
    create_permission("dfe")
    create_permission("cima")
    create_permission("institute-of-financial-accountants")
    create_permission("waterways-ireland")
    create_permission("cih-scotland")
    create_permission("office-of-the-registrar-of-independent-schools")
    create_permission("the-bar-council-of-northern-ireland")
    create_permission("samu")
    create_permission("insolvency-service")
    create_permission("egg-and-poultry-unit,-scottish-ministers")
    create_permission("aberdeen")
    create_permission("aberdeenshire")
    create_permission("adur")
    create_permission("allerdale")
    create_permission("amber-valley")
    create_permission("angus")
    create_permission("antrim")
    create_permission("ards")
    create_permission("argyll-and-bute")
    create_permission("armagh")
    create_permission("arun")
    create_permission("ashfield")
    create_permission("ashford")
    create_permission("aylesbury-vale")
    create_permission("babergh")
    create_permission("ballymena")
    create_permission("ballymoney")
    create_permission("banbridge")
    create_permission("barking-and-dagenham")
    create_permission("barnet")
    create_permission("barnsley")
    create_permission("barrow-in-furness")
    create_permission("basildon")
    create_permission("basingstoke-and-deane")
    create_permission("bassetlaw")
    create_permission("bath-and-north-east-somerset")
    create_permission("bedford")
    create_permission("belfast")
    create_permission("bexley")
    create_permission("birmingham")
    create_permission("blaby")
    create_permission("blackburn-with-darwen")
    create_permission("blackpool")
    create_permission("blaenau-gwent")
    create_permission("bolsover")
    create_permission("bolton")
    create_permission("boston")
    create_permission("bournemouth")
    create_permission("bracknell-forest")
    create_permission("bradford")
    create_permission("braintree")
    create_permission("breckland")
    create_permission("brent")
    create_permission("brentwood")
    create_permission("bromsgrove")
    create_permission("broxtowe")
    create_permission("bridgend")
    create_permission("brighton-and-hove")
    create_permission("bristol")
    create_permission("broadland")
    create_permission("bromley")
    create_permission("broxbourne")
    create_permission("buckinghamshire")
    create_permission("burnley")
    create_permission("bury")
    create_permission("caerphilly")
    create_permission("calderdale")
    create_permission("cambridge")
    create_permission("cambridgeshire")
    create_permission("camden")
    create_permission("cannock-chase")
    create_permission("canterbury")
    create_permission("cardiff")
    create_permission("carlisle")
    create_permission("carmarthenshire")
    create_permission("carrickfergus")
    create_permission("castle-point")
    create_permission("castlereagh")
    create_permission("central-bedfordshire")
    create_permission("ceredigion")
    create_permission("charnwood")
    create_permission("chelmsford")
    create_permission("cheltenham")
    create_permission("cherwell")
    create_permission("cheshire-east")
    create_permission("cheshire-west-and-chester")
    create_permission("chesterfield")
    create_permission("chichester")
    create_permission("chiltern")
    create_permission("chorley")
    create_permission("christchurch")
    create_permission("city-of-london")
    create_permission("clackmannanshire")
    create_permission("colchester")
    create_permission("coleraine")
    create_permission("conwy")
    create_permission("cookstown")
    create_permission("copeland")
    create_permission("corby")
    create_permission("cornwall")
    create_permission("cotswold")
    create_permission("county-durham")
    create_permission("coventry")
    create_permission("craigavon")
    create_permission("craven")
    create_permission("crawley")
    create_permission("croydon")
    create_permission("cumbria")
    create_permission("dacorum")
    create_permission("darlington")
    create_permission("dartford")
    create_permission("daventry")
    create_permission("denbighshire")
    create_permission("derby")
    create_permission("derbyshire")
    create_permission("derbyshire-dales")
    create_permission("derry")
    create_permission("devon")
    create_permission("doncaster")
    create_permission("dorset")
    create_permission("dover")
    create_permission("down")
    create_permission("dudley")
    create_permission("dumfries-and-galloway")
    create_permission("dundee")
    create_permission("dungannon-and-south-tyrone")
    create_permission("ealing")
    create_permission("east-ayrshire")
    create_permission("east-cambridgeshire")
    create_permission("east-devon")
    create_permission("east-dorset")
    create_permission("east-dunbartonshire")
    create_permission("east-hampshire")
    create_permission("east-hertfordshire")
    create_permission("east-lindsey")
    create_permission("east-lothian")
    create_permission("east-northamptonshire")
    create_permission("east-renfrewshire")
    create_permission("east-riding-of-yorkshire")
    create_permission("east-staffordshire")
    create_permission("east-sussex")
    create_permission("eastbourne")
    create_permission("eastleigh")
    create_permission("eden")
    create_permission("edinburgh")
    create_permission("eilean-siar")
    create_permission("elmbridge")
    create_permission("enfield")
    create_permission("epping-forest")
    create_permission("epsom-and-ewell")
    create_permission("erewash")
    create_permission("essex")
    create_permission("exeter")
    create_permission("falkirk")
    create_permission("fareham")
    create_permission("fenland")
    create_permission("fermanagh")
    create_permission("fife")
    create_permission("flintshire")
    create_permission("forest-heath")
    create_permission("forest-of-dean")
    create_permission("fylde")
    create_permission("gateshead")
    create_permission("gedling")
    create_permission("glasgow")
    create_permission("gloucester")
    create_permission("gloucestershire")
    create_permission("gosport")
    create_permission("gravesham")
    create_permission("great-yarmouth")
    create_permission("greenwich")
    create_permission("guildford")
    create_permission("gwynedd")
    create_permission("hackney")
    create_permission("halton")
    create_permission("hambleton")
    create_permission("hammersmith-and-fulham")
    create_permission("hampshire")
    create_permission("harborough")
    create_permission("haringey")
    create_permission("harlow")
    create_permission("harrogate")
    create_permission("harrow")
    create_permission("hart")
    create_permission("hartlepool")
    create_permission("hastings")
    create_permission("havant")
    create_permission("havering")
    create_permission("herefordshire")
    create_permission("hertfordshire")
    create_permission("hertsmere")
    create_permission("high-peak")
    create_permission("highland")
    create_permission("hillingdon")
    create_permission("hinckley-and-bosworth")
    create_permission("horsham")
    create_permission("hounslow")
    create_permission("huntingdonshire")
    create_permission("hyndburn")
    create_permission("inverclyde")
    create_permission("ipswich")
    create_permission("isle-of-anglesey")
    create_permission("isle-of-wight")
    create_permission("isles-of-scilly")
    create_permission("islington")
    create_permission("kensington-and-chelsea")
    create_permission("kent")
    create_permission("kettering")
    create_permission("kings-lynn-and-west-norfolk")
    create_permission("kingston-upon-hull")
    create_permission("kingston-upon-thames")
    create_permission("kirklees")
    create_permission("knowsley")
    create_permission("lambeth")
    create_permission("lancashire")
    create_permission("lancaster")
    create_permission("larne")
    create_permission("leeds")
    create_permission("leicester")
    create_permission("leicestershire")
    create_permission("lewes")
    create_permission("lewisham")
    create_permission("lichfield")
    create_permission("limavady")
    create_permission("lincoln")
    create_permission("lincolnshire")
    create_permission("lisburn")
    create_permission("liverpool")
    create_permission("luton")
    create_permission("magherafelt")
    create_permission("maidstone")
    create_permission("maldon")
    create_permission("malvern-hills")
    create_permission("manchester")
    create_permission("mansfield")
    create_permission("medway")
    create_permission("melton")
    create_permission("mendip")
    create_permission("merthyr-tydfil")
    create_permission("merton")
    create_permission("mid-devon")
    create_permission("mid-suffolk")
    create_permission("mid-sussex")
    create_permission("middlesbrough")
    create_permission("midlothian")
    create_permission("milton-keynes")
    create_permission("mole-valley")
    create_permission("monmouthshire")
    create_permission("moray")
    create_permission("moyle")
    create_permission("neath-port-talbot")
    create_permission("new-forest")
    create_permission("newark-and-sherwood")
    create_permission("newcastle-upon-tyne")
    create_permission("newcastle-under-lyme")
    create_permission("newham")
    create_permission("newport")
    create_permission("newry-and-mourne")
    create_permission("newtownabbey")
    create_permission("norfolk")
    create_permission("north-ayrshire")
    create_permission("north-devon")
    create_permission("north-dorset")
    create_permission("north-down")
    create_permission("north-east-derbyshire")
    create_permission("north-east-lincolnshire")
    create_permission("north-hertfordshire")
    create_permission("north-kesteven")
    create_permission("north-lanarkshire")
    create_permission("north-lincolnshire")
    create_permission("north-norfolk")
    create_permission("north-somerset")
    create_permission("north-tyneside")
    create_permission("north-warwickshire")
    create_permission("north-west-leicestershire")
    create_permission("north-yorkshire")
    create_permission("northampton")
    create_permission("northamptonshire")
    create_permission("northumberland")
    create_permission("norwich")
    create_permission("nottingham")
    create_permission("nottinghamshire")
    create_permission("nuneaton-and-bedworth")
    create_permission("oadby-and-wigston")
    create_permission("oldham")
    create_permission("omagh")
    create_permission("orkney-islands")
    create_permission("oxford")
    create_permission("oxfordshire")
    create_permission("pembrokeshire")
    create_permission("pendle")
    create_permission("perth-and-kinross")
    create_permission("peterborough")
    create_permission("plymouth")
    create_permission("poole")
    create_permission("portsmouth")
    create_permission("powys")
    create_permission("preston")
    create_permission("purbeck")
    create_permission("reading")
    create_permission("redbridge")
    create_permission("redcar-and-cleveland")
    create_permission("redditch")
    create_permission("reigate-and-banstead")
    create_permission("renfrewshire")
    create_permission("rhondda-cynon-taff")
    create_permission("ribble-valley")
    create_permission("richmond-upon-thames")
    create_permission("richmondshire")
    create_permission("rochdale")
    create_permission("rochford")
    create_permission("rossendale")
    create_permission("rother")
    create_permission("rotherham")
    create_permission("rugby")
    create_permission("runnymede")
    create_permission("rushcliffe")
    create_permission("rushmoor")
    create_permission("rutland")
    create_permission("ryedale")
    create_permission("salford")
    create_permission("sandwell")
    create_permission("scarborough")
    create_permission("scottish-borders")
    create_permission("sedgemoor")
    create_permission("sefton")
    create_permission("selby")
    create_permission("sevenoaks")
    create_permission("sheffield")
    create_permission("shepway")
    create_permission("shetland-islands")
    create_permission("shropshire")
    create_permission("slough")
    create_permission("solihull")
    create_permission("somerset")
    create_permission("south-ayrshire")
    create_permission("south-bucks")
    create_permission("south-cambridgeshire")
    create_permission("south-derbyshire")
    create_permission("south-gloucestershire")
    create_permission("south-hams")
    create_permission("south-holland")
    create_permission("south-kesteven")
    create_permission("south-lakeland")
    create_permission("south-lanarkshire")
    create_permission("south-norfolk")
    create_permission("south-northamptonshire")
    create_permission("south-oxfordshire")
    create_permission("south-ribble")
    create_permission("south-somerset")
    create_permission("south-staffordshire")
    create_permission("south-tyneside")
    create_permission("southampton")
    create_permission("southend-on-sea")
    create_permission("southwark")
    create_permission("spelthorne")
    create_permission("st-albans")
    create_permission("st-edmundsbury")
    create_permission("st-helens")
    create_permission("stafford")
    create_permission("staffordshire")
    create_permission("staffordshire-moorlands")
    create_permission("stevenage")
    create_permission("stirling")
    create_permission("stockport")
    create_permission("stockton-on-tees")
    create_permission("stoke-on-trent")
    create_permission("strabane")
    create_permission("stratford-on-avon")
    create_permission("stroud")
    create_permission("suffolk")
    create_permission("suffolk-coastal")
    create_permission("sunderland")
    create_permission("surrey")
    create_permission("surrey-heath")
    create_permission("sutton")
    create_permission("swale")
    create_permission("swansea")
    create_permission("swindon")
    create_permission("tendring")
    create_permission("test-valley")
    create_permission("tewkesbury")
    create_permission("thanet")
    create_permission("tonbridge-and-malling")
    create_permission("tameside")
    create_permission("tamworth")
    create_permission("tandridge")
    create_permission("taunton-deane")
    create_permission("teignbridge")
    create_permission("telford-and-wrekin")
    create_permission("three-rivers")
    create_permission("thurrock")
    create_permission("torbay")
    create_permission("torfaen")
    create_permission("torridge")
    create_permission("tower-hamlets")
    create_permission("trafford")
    create_permission("tunbridge-wells")
    create_permission("uttlesford")
    create_permission("vale-of-glamorgan")
    create_permission("vale-of-white-horse")
    create_permission("wakefield")
    create_permission("walsall")
    create_permission("waltham-forest")
    create_permission("wandsworth")
    create_permission("warrington")
    create_permission("warwick")
    create_permission("warwickshire")
    create_permission("watford")
    create_permission("waveney")
    create_permission("waverley")
    create_permission("wealden")
    create_permission("wellingborough")
    create_permission("welwyn-hatfield")
    create_permission("west-berkshire")
    create_permission("west-devon")
    create_permission("west-dorset")
    create_permission("west-dunbartonshire")
    create_permission("west-lancashire")
    create_permission("west-lindsey")
    create_permission("west-lothian")
    create_permission("west-oxfordshire")
    create_permission("west-somerset")
    create_permission("west-sussex")
    create_permission("westminster")
    create_permission("weymouth-and-portland")
    create_permission("wigan")
    create_permission("wiltshire")
    create_permission("winchester")
    create_permission("windsor-and-maidenhead")
    create_permission("wirral")
    create_permission("woking")
    create_permission("wokingham")
    create_permission("wolverhampton")
    create_permission("worcester")
    create_permission("worcestershire")
    create_permission("worthing")
    create_permission("wrexham")
    create_permission("wychavon")
    create_permission("wycombe")
    create_permission("wyre")
    create_permission("wyre-forest")
    create_permission("york")
  end

  def down; end

  class ::Doorkeeper::Application < ActiveRecord::Base
    has_many :permissions, dependent: :destroy
    has_many :supported_permissions, dependent: :destroy

    def self.default_permission_strings
      %w[signin]
    end

    def supported_permission_strings
      self.class.default_permission_strings + supported_permissions.order(:name).map(&:name)
    end

    def url_without_path
      parsed_url = URI.parse(redirect_uri)
      url_without_path = "#{parsed_url.scheme}://#{parsed_url.host}:#{parsed_url.port}"
    end
  end

private

  def licence_application
    Doorkeeper::Application.where(name: "Licensify").first
  end

  def create_permission(permission)
    app = licence_application

    if(!app.nil?)
      app.supported_permissions.find_or_create_by(name: permission)
 end
end
end
