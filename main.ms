Experience Welcome {
    String img value("https://i.imgur.com/hSKMazT.png") as Image
    String title value("Corona App") as Label
}

Experience Main {
    String t1 value("https://i.imgur.com/Ty8c1QL.png") as Image
    String t2 value("https://i.imgur.com/BLZPO4C.png") as Image
    String t3 value("https://i.imgur.com/gbAW3ck.png") as Image
    String t4 value("https://i.imgur.com/EkbRsMm.png") as Image
}

Experience Contact {
    Array<contact> c value([]) as List
}

Experience Synthoms {
    String s1 value("https://i.imgur.com/Sco1Kgk.png") as Image

}

Experience Precautions {
    String i value("https://i.imgur.com/GM0J25n.png") as Image
}


Experience Statistics {
    Integer casesW as Label
    Integer deathsW as Label
    Integer recoveredW as Label
    Array<Country> paises as List
}

Model contact {
    String title
    String num
}

Model World {
    Integer deaths
    Integer cases
    Integer recovered
}

Model Country {
    String country
    Integer cases
    Integer deaths
    Integer recovered
}

Application {
    Map<String> info 
    Array<Country> countries
    Timer timer
    Synthoms expSynthoms
    Contact expContact
    Precautions expPrecautions
    Statistics expStatistics
    
    OnInit {
        info = {"Nivel Nacional Salud Responde":"0800 222 1002", "Ciudad Autónoma de Buenos Aires": "107", "Provincia de Buenos Aires":"148", "Entre Ríos":"107", "Corrientes":"0379 4974811/ 4895124", "Misiones":"0800 444 3400", "Santa Fe":"0800 555 6549", "Chaco":"0800 444 0829", "Formosa":"107", "Salta":"911", "Jujuy":"0800 888 4767", "Santiago del Estero":"107/ 385 4213006/ 5237077", "Tucumán":"0800 555 8478/ 0381 4302228", "Catamarca":"383 154238872", "La Rioja":"107/ 911", "Córdoba":"0800 122 1444", "San Juan":"107", "San Luis":"107", "Mendoza":"0800 800 26843", "La Pampa":"0800 333 1135", "Neuquén":"0800 33 1002", "Río Negro":"911", "Chubut":"0800 222 2676", "Santa Cruz":"107", "Tierra del Fuego":"107"}
        
        expSynthoms = Synthoms()
        expContact = Contact()
        expPrecautions = Precautions()
        expStatistics = Statistics()
        
        Array<String> clave = info.keys()
        Array<String> valor = info.values()
        Integer i = 0
        while(i < info.size()) {
            contact cc = contact()
            cc.title = clave.get(i)
            cc.num = valor.get(i)
            expContact.c.add(cc)
            ++i
        }
        
        World w = World()
        
        
        w = service.coronaW.call()
        
        expStatistics.paises = service.corona.call()
        
        expStatistics.casesW = w.cases
        expStatistics.deathsW = w.deaths
        expStatistics.recoveredW = w.recovered
        
        timer = Timer(delay:2, function:@function(MainModule.func), repeat:false)
        
        Welcome welc = Welcome()
        broker.ui.push("Welcome", welc)
        timer.start()
    }
}


RuleContext MainContext {
    Rule r2 {
        broker.ui.push("Synthoms", expSynthoms)
    }
    
    Rule r3 {
        broker.ui.push("Precautions", expPrecautions)
    }
    
    Rule r1 {
        broker.ui.push("Statistics", expStatistics)
    }
    
    Rule r4 {
        broker.ui.push("Contact", expContact)
    }
}

Module MainModule {
    void func(Timer t){
        Main exp = Main()
        broker.ui.push("Main", exp)
    }
}

