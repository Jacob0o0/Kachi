import Foundation
import Combine

struct Texto {
    let español: String
    let nahuatl: String?
    let otomi: String?
    let totonaco: String?
}

struct Historia: Identifiable {
    let id = UUID() // Identificador único
    let titulo_español: String
    let titulo_nahuatl: String?
    let titulo_otomi: String?
    let titulo_totonaco: String?
    let cultura_origen: String
    let parrafos: [Texto]
    let imagen: String
}

struct Categoria: Identifiable {
    let id = UUID() // Identificador único
    let nombre: Texto
    let icono: String
}

struct Traduccion: Codable, Equatable, Identifiable {
    var id = UUID()
    let deLengua: String
    let aLengua: String
    let textoOriginal: String
    let textoTraducido: String
}


extension UserDefaults {
    func setCodable<T: Codable>(_ value: T, forKey key: String) {
        if let data = try? JSONEncoder().encode(value) {
            set(data, forKey: key)
        }
    }
    
    func getCodable<T: Codable>(forKey key: String, as type: T.Type) -> T? {
        if let data = data(forKey: key) {
            return try? JSONDecoder().decode(type, from: data)
        }
        return nil
    }
}

class TraduccionStore: ObservableObject {
    @Published var traducciones: [Traduccion] {
        didSet {
            // Guardar automáticamente en UserDefaults cada vez que se actualice
            UserDefaults.standard.setCodable(traducciones, forKey: "traduccionesGuardadas")
        }
    }
    
    init() {
        // Cargar traducciones desde UserDefaults al iniciar
        self.traducciones = UserDefaults.standard.getCodable(forKey: "traduccionesGuardadas", as: [Traduccion].self) ?? []
    }
    
    func agregarTraduccion(_ traduccion: Traduccion) {
            // Agregar la nueva traducción al principio de la lista
            traducciones.insert(traduccion, at: 0)
            
            // Mantener solo las últimas 10 traducciones
            if traducciones.count > 10 {
                traducciones = Array(traducciones.prefix(10))
            }
        }
}

class AppData: ObservableObject {
    static let shared = AppData(
        saludo_dia: Texto(español: "¡Buen día!", nahuatl: "¡Mah cualli tonalli!", otomi: "¡Ki hats'i!", totonaco: "¡Kuinilh"),
        categorias: [
            Categoria(nombre: Texto(español: "Cultura", nahuatl: "CulturaN", otomi: "CulturaO", totonaco: "CulturaT"), icono: "Cultura"),
            Categoria(nombre: Texto(español: "Relaciones", nahuatl: "CulturaN", otomi: "CulturaO", totonaco: "CulturaT"), icono: "Relaciones"),
            Categoria(nombre: Texto(español: "Trabajo", nahuatl: "CulturaN", otomi: "CulturaO", totonaco: "CulturaT"), icono: "Trabajo"),
            Categoria(nombre: Texto(español: "Comida", nahuatl: "CulturaN", otomi: "CulturaO", totonaco: "CulturaT"), icono: "Comida"),
            Categoria(nombre: Texto(español: "Casa", nahuatl: "CulturaN", otomi: "CulturaO", totonaco: "CulturaT"), icono: "Casa"),
            Categoria(nombre: Texto(español: "Viajes", nahuatl: "CulturaN", otomi: "CulturaO", totonaco: "CulturaT"), icono: "Viajes")
        ],
        cuentos: [
            Historia(
                titulo_español: "El Alacrán y el Zanete",
                titulo_nahuatl: "Se ko:lotl wan se tsana",
                titulo_otomi: nil,
                titulo_totonaco: nil,
                cultura_origen: "nahuatl",
                parrafos: [
                    Texto(
                        español: "Cuando el alacrán vino al mundo, vino con la intención de matar a quien picara, pero para que ello fuera posible tenía que ayunar siete días.",
                        nahuatl: "Ke:ma nopa ko:lotl walki ipan ni: tlaltepaktli, walki para kinmiktis san ahkia kimiktis, pero para weliskiya, moneki axtlakwa chikome tonati.",
                        otomi: nil,
                        totonaco: nil),
                    Texto(
                        español: "Iba ya en el sexto día de su abstinencia, cuando volando, llegó a pararse en el suelo un zanete.",
                        nahuatl: "Yowiyaya ipan chikwase tonati axtlakwatoya, kema patlantoya asiko mosewiko ipan talli/tlaltepaktli se tsana.",
                        otomi: nil,
                        totonaco: nil),
                    Texto(
                        español: "El alacrán estaba acostado junto a una piedra y el zanete, al verlo, con miedo lo interrogó:",
                        nahuatl: "Nopa ko:lotl motekatoya seho se tetl, iwan nopa tsana, keme kiitak ika mahmawilistli kitlahtlanili:",
                        otomi: nil,
                        totonaco: nil),
                    Texto(
                        español: "— ¿Qué haces alacrancito?",
                        nahuatl: "- ¿Tle:n tichi:wa pilkolo:tsin?",
                        otomi: nil,
                        totonaco: nil),
                    Texto(
                        español: "Y el alacrán le contestó:",
                        nahuatl: "Wan ne ko:lotl kinankilihi:",
                        otomi: nil,
                        totonaco: nil),
                    Texto(
                        español: "— Pues estoy aquí ayunando",
                        nahuatl: "- San nika axnitlakwa",
                        otomi: nil,
                        totonaco: nil),
                    Texto(
                        español: "— ¿Y por qué? —le preguntó el zanete.",
                        nahuatl: "- ¿Wan kenke? Kitlatlanilihi no:pa tsana.",
                        otomi: nil,
                        totonaco: nil),
                    Texto(
                        español: "— ¡Ah! Porque a quien yo pique se tiene que morir. ",
                        nahuatl: "- ¡Ah! Pampa ahkia na: nikwa moneki mikis.",
                        otomi: nil,
                        totonaco: nil),
                    Texto(
                        español: "El zanete le dijo:",
                        nahuatl: "No:pa tsana kilihi:",
                        otomi: nil,
                        totonaco: nil),
                    Texto(
                        español: "— ¡Hummmmm…! No creo que lo logres porque eres bien chiquito.",
                        nahuatl: "- ¡Hummmm…! Axnimiktokiliya tla tichiwas, pampa tlawel tipilkwekwetsin.",
                        otomi: nil,
                        totonaco: nil),
                    Texto(
                        español: "Lo que deberías hacer es comer como yo.",
                        nahuatl: "Moneki tichiwaskiya titlakwas kewal na.",
                        otomi: nil,
                        totonaco: nil),
                    Texto(
                        español: "¡Si vieras qué contento me pongo cuando estoy lleno!",
                        nahuatl: "¡Tla timatiskiya kenihkatsa niyolpaki kema niixwitok.",
                        otomi: nil,
                        totonaco: nil),
                    Texto(
                        español: "Pero el alacrán buscaba razones y se defendía. Entonces el zanete tuvo una idea y lo instigó:",
                        nahuatl: "Pero ne: ko:lotl kitemoyaya tlamantli, wan momanawiyaya nopa tsana kipixki se tlamantli wan kitlahtlanilihi:",
                        otomi: nil,
                        totonaco: nil),
                    Texto(
                        español: "— Pícame mejor en una pata a ver si de verdad picas fuerte.",
                        nahuatl: "- Xine:chkwa ipan se noikxi tla: neliya chkawak tite:kwa.",
                        otomi: nil,
                        totonaco: nil),
                    Texto(
                        español: "El alacrán molesto le picó una pata, pero el zanete le dijo:",
                        nahuatl: "Nopa ko:lotl mosisinitok kikwahi ipan iikx pero no:pa tsana kilihi:",
                        otomi: nil,
                        totonaco: nil),
                    Texto(
                        español: "— No sentí nada, mejor ya come, ya no estés sufriendo.",
                        nahuatl: "- Axtle:n nimachilihi, mejor xitlakwaya, ayohana xitlaihyowi.",
                        otomi: nil,
                        totonaco: nil),
                    Texto(
                        español: "Y el alacrán empezó a comer de su pata.",
                        nahuatl: "Iwan nopa kolotl pehi kikwa ikxi nopa tsana.",
                        otomi: nil,
                        totonaco: nil),
                    Texto(
                        español: "Ya mero terminaba cuando el zanete voló hasta la rama de un árbol mientras chillaba fuertemente porque los piquetes del alacrán habían sido tremendos.",
                        nahuatl: "Kema tlaniyaya nopa tsana patlantehi iean mosewito imakayo se kwawitl iwan tsatsiyaya chikawak, pampa no:pa ite:nkokoyo nopa ko:lotl temahmati chikawak.",
                        otomi: nil,
                        totonaco: nil),
                    Texto(
                        español: "Es por eso que por donde anda el zanete se oyen claramente sus chillidos.",
                        nahuatl: "Yeka kampanemi nopa tsana mokaki kwalli itsatsilis.",
                        otomi: nil,
                        totonaco: nil),
                    Texto(
                        español: "Fuerte fue el piquete de verdad, pero el zanete salvó al hombre de este mundo de morir picado por el alacrán",
                        nahuatl: "Tlawel chikawak kikwahi pero nopa tsana kimanawihi nopa tlakatl ipan no:pa tlaltepaktli para axmikis.",
                        otomi: nil,
                        totonaco: nil)
                ],
                imagen: "alacran_y_zanate"
            ),
            Historia(
                titulo_español: "La ciudad sitiada",
                titulo_nahuatl: nil,
                titulo_otomi: nil,
                titulo_totonaco: nil,
                cultura_origen: "nahuatl",
                parrafos: [
                    Texto(
                        español: "Y todo esto pasó con nosotros. Nosotros lo vimos, nosotros lo admiramos: con esta lamentosa y triste suerte nos vimos angustiados.",
                        nahuatl: "Au in yeixkichi ipa mochiua in tikittake intikmauisoke in techokti tetlaokolti inik tlaijiyouike.",
                        otomi: nil,
                        totonaco: nil),
                    Texto(
                        español: "Destechadas están las casas, enrojecidos tienen sus muros.",
                        nahuatl: "Kali tsontlapoutok kali chichiliutok.",
                        otomi: nil,
                        totonaco: nil),
                    Texto(español: "Gusanos pululan por calles y plazas, y en las paredes están los sesos.",
                          nahuatl: "Okuilti moyakatlamina otlika. Au inkaltech, jajalakatok in kuatextli.",
                          otomi: nil,
                          totonaco: nil),
                    Texto(español: "Rojas están las aguas, están como teñidas, y cuando las bebimos, es como si bebiéramos agua de salitre.",
                          nahuatl: "Au yn atl sa yuki chichiltik sa yuki tlapatlatl ka yu tikike tikia tekixkiatl.",
                          otomi: nil,
                          totonaco: nil),
                    Texto(español: "Golpeábamos, en tanto, los muros de adobe, y era nuestra herencia una red de agujeros. Con los escudos fue su resguardo, pero ni con escudos puede ser sostenida su soledad. Hemos comido palos de colorín (eritrina), hemos masticado grama salitrosa, piedras de adobe, lagartijas, ratones, tierra en polvo, gusanos… Comimos la carne apenas sobre el fuego estaba puesta. Cuando estaba cocida la carne de allí la arrebataban, en el fuego mismo, la comían.",
                          nahuatl: "Au ok ipa tiktetsotsonaya xamitl, au in atlakomoli ka toneixkauil chimaltitla in ipialoya in ok nen aka nik kisekilisneki [mote ysemilisneki] sa chimaltitlan tikkuake in tsonpa kuauitl in tekix­ki­sakatl xantetl in kuetspali kimichi teutlakili. Okuili titone techquake in akaselotl in ikuak tlepa kimontlaliaya y ye yusik inakayo onkan konouio… tleko kiquaya.",
                          otomi: nil,
                          totonaco: nil),
                    Texto(español: "Se nos puso precio. Precio del joven, del sacerdote, del niño y de la doncella. Basta: de un pobre era el precio sólo dos puñados de maíz, sólo diez tortas de mosco; sólo era nuestro precio veinte tortas de grama salitrosa.",
                          nahuatl: "Au in topatiu mochiu in ipatiu mochiu, telpochtli itlakasitiu mochiu kano matechoktik axaxayaka, tlaxkali in tlamakaski, in ichpochtli, in piltsintli in ye ixkich maseuali in ipatiu mochiu sa omatekuchtli tlaoli sa matlaktli axaxayakatlaxkali tekixkisakatlaxkali sa sempouali tonatiu topatiu.",
                          otomi: nil,
                          totonaco: nil),
                    Texto(español: "Oro, jades, mantas ricas, plumajes de quetzal, todo eso que es precioso, en nada fue estimado. Solamente se echó fuera del mercado a la gente cuando allí se colocó la catapulta.",
                          nahuatl: "Mochiu in teokuitlatl, in chalchiuitl in kuachtli in ketsali ye ixkich tlasotli atleypa mottak sa tetepeui in oyu konketske kuautematlatl in tiankisko.",
                          otomi: nil,
                          totonaco: nil),
                    Texto(español: "Ahora bien, a Cuauhtémoc le llevaban los cautivos. No quedan así. Los que llevan a los cautivos son los capitanes de Tlacatecco. De un lado y de otro les abren el vientre. Les abría el vientre Cuauhtemoctzin en persona y por sí mismo.",
                          nahuatl: "Au yeuatsin Kuautemoktsin kimouikilia in malti amo yu kikaua in tekauato achkauti tlatlakateka nekok kitititsa kimititlapanaya yoma Kuautemoktsin.",
                          otomi: nil,
                          totonaco: nil)
                ],
                imagen: "ciudad"
            ),
        ],
        cuentosDestacados: [
            Historia(
                titulo_español: "La ciudad sitiada",
                titulo_nahuatl: "Ueyaltepetl",
                titulo_otomi: nil,
                titulo_totonaco: nil,
                cultura_origen: "nahuatl",
                parrafos: [
                    Texto(
                        español: "Y todo esto pasó con nosotros. Nosotros lo vimos, nosotros lo admiramos: con esta lamentosa y triste suerte nos vimos angustiados.",
                        nahuatl: "Au in yeixkichi ipa mochiua in tikittake intikmauisoke in techokti tetlaokolti inik tlaijiyouike.",
                        otomi: nil,
                        totonaco: nil),
                    Texto(
                        español: "Destechadas están las casas, enrojecidos tienen sus muros.",
                        nahuatl: "Kali tsontlapoutok kali chichiliutok.",
                        otomi: nil,
                        totonaco: nil),
                    Texto(español: "Gusanos pululan por calles y plazas, y en las paredes están los sesos.",
                          nahuatl: "Okuilti moyakatlamina otlika. Au inkaltech, jajalakatok in kuatextli.",
                          otomi: nil,
                          totonaco: nil),
                    Texto(español: "Rojas están las aguas, están como teñidas, y cuando las bebimos, es como si bebiéramos agua de salitre.",
                          nahuatl: "Au yn atl sa yuki chichiltik sa yuki tlapatlatl ka yu tikike tikia tekixkiatl.",
                          otomi: nil,
                          totonaco: nil),
                    Texto(español: "Golpeábamos, en tanto, los muros de adobe, y era nuestra herencia una red de agujeros. Con los escudos fue su resguardo, pero ni con escudos puede ser sostenida su soledad. Hemos comido palos de colorín (eritrina), hemos masticado grama salitrosa, piedras de adobe, lagartijas, ratones, tierra en polvo, gusanos… Comimos la carne apenas sobre el fuego estaba puesta. Cuando estaba cocida la carne de allí la arrebataban, en el fuego mismo, la comían.",
                          nahuatl: "Au ok ipa tiktetsotsonaya xamitl, au in atlakomoli ka toneixkauil chimaltitla in ipialoya in ok nen aka nik kisekilisneki [mote ysemilisneki] sa chimaltitlan tikkuake in tsonpa kuauitl in tekix­ki­sakatl xantetl in kuetspali kimichi teutlakili. Okuili titone techquake in akaselotl in ikuak tlepa kimontlaliaya y ye yusik inakayo onkan konouio… tleko kiquaya.",
                          otomi: nil,
                          totonaco: nil),
                    Texto(español: "Se nos puso precio. Precio del joven, del sacerdote, del niño y de la doncella. Basta: de un pobre era el precio sólo dos puñados de maíz, sólo diez tortas de mosco; sólo era nuestro precio veinte tortas de grama salitrosa.",
                          nahuatl: "Au in topatiu mochiu in ipatiu mochiu, telpochtli itlakasitiu mochiu kano matechoktik axaxayaka, tlaxkali in tlamakaski, in ichpochtli, in piltsintli in ye ixkich maseuali in ipatiu mochiu sa omatekuchtli tlaoli sa matlaktli axaxayakatlaxkali tekixkisakatlaxkali sa sempouali tonatiu topatiu.",
                          otomi: nil,
                          totonaco: nil),
                    Texto(español: "Oro, jades, mantas ricas, plumajes de quetzal, todo eso que es precioso, en nada fue estimado. Solamente se echó fuera del mercado a la gente cuando allí se colocó la catapulta.",
                          nahuatl: "Mochiu in teokuitlatl, in chalchiuitl in kuachtli in ketsali ye ixkich tlasotli atleypa mottak sa tetepeui in oyu konketske kuautematlatl in tiankisko.",
                          otomi: nil,
                          totonaco: nil),
                    Texto(español: "Ahora bien, a Cuauhtémoc le llevaban los cautivos. No quedan así. Los que llevan a los cautivos son los capitanes de Tlacatecco. De un lado y de otro les abren el vientre. Les abría el vientre Cuauhtemoctzin en persona y por sí mismo.",
                          nahuatl: "Au yeuatsin Kuautemoktsin kimouikilia in malti amo yu kikaua in tekauato achkauti tlatlakateka nekok kitititsa kimititlapanaya yoma Kuautemoktsin.",
                          otomi: nil,
                          totonaco: nil)
                ],
                imagen: "ciudad"
            ),
            Historia(
                titulo_español: "El Alacrán y el Zanete",
                titulo_nahuatl: "Se ko:lotl wan se tsana",
                titulo_otomi: nil,
                titulo_totonaco: nil,
                cultura_origen: "nahuatl",
                parrafos: [
                    Texto(
                        español: "Cuando el alacrán vino al mundo, vino con la intención de matar a quien picara, pero para que ello fuera posible tenía que ayunar siete días.",
                        nahuatl: "Ke:ma nopa ko:lotl walki ipan ni: tlaltepaktli, walki para kinmiktis san ahkia kimiktis, pero para weliskiya, moneki axtlakwa chikome tonati.",
                        otomi: nil,
                        totonaco: nil),
                    Texto(
                        español: "Iba ya en el sexto día de su abstinencia, cuando volando, llegó a pararse en el suelo un zanete.",
                        nahuatl: "Yowiyaya ipan chikwase tonati axtlakwatoya, kema patlantoya asiko mosewiko ipan talli/tlaltepaktli se tsana.",
                        otomi: nil,
                        totonaco: nil),
                    Texto(
                        español: "El alacrán estaba acostado junto a una piedra y el zanete, al verlo, con miedo lo interrogó:",
                        nahuatl: "Nopa ko:lotl motekatoya seho se tetl, iwan nopa tsana, keme kiitak ika mahmawilistli kitlahtlanili:",
                        otomi: nil,
                        totonaco: nil),
                    Texto(
                        español: "— ¿Qué haces alacrancito?",
                        nahuatl: "- ¿Tle:n tichi:wa pilkolo:tsin?",
                        otomi: nil,
                        totonaco: nil),
                    Texto(
                        español: "Y el alacrán le contestó:",
                        nahuatl: "Wan ne ko:lotl kinankilihi:",
                        otomi: nil,
                        totonaco: nil),
                    Texto(
                        español: "— Pues estoy aquí ayunando",
                        nahuatl: "- San nika axnitlakwa",
                        otomi: nil,
                        totonaco: nil),
                    Texto(
                        español: "— ¿Y por qué? —le preguntó el zanete.",
                        nahuatl: "- ¿Wan kenke? Kitlatlanilihi no:pa tsana.",
                        otomi: nil,
                        totonaco: nil),
                    Texto(
                        español: "— ¡Ah! Porque a quien yo pique se tiene que morir. ",
                        nahuatl: "- ¡Ah! Pampa ahkia na: nikwa moneki mikis.",
                        otomi: nil,
                        totonaco: nil),
                    Texto(
                        español: "El zanete le dijo:",
                        nahuatl: "No:pa tsana kilihi:",
                        otomi: nil,
                        totonaco: nil),
                    Texto(
                        español: "— ¡Hummmmm…! No creo que lo logres porque eres bien chiquito.",
                        nahuatl: "- ¡Hummmm…! Axnimiktokiliya tla tichiwas, pampa tlawel tipilkwekwetsin.",
                        otomi: nil,
                        totonaco: nil),
                    Texto(
                        español: "Lo que deberías hacer es comer como yo.",
                        nahuatl: "Moneki tichiwaskiya titlakwas kewal na.",
                        otomi: nil,
                        totonaco: nil),
                    Texto(
                        español: "¡Si vieras qué contento me pongo cuando estoy lleno!",
                        nahuatl: "¡Tla timatiskiya kenihkatsa niyolpaki kema niixwitok.",
                        otomi: nil,
                        totonaco: nil),
                    Texto(
                        español: "Pero el alacrán buscaba razones y se defendía. Entonces el zanete tuvo una idea y lo instigó:",
                        nahuatl: "Pero ne: ko:lotl kitemoyaya tlamantli, wan momanawiyaya nopa tsana kipixki se tlamantli wan kitlahtlanilihi:",
                        otomi: nil,
                        totonaco: nil),
                    Texto(
                        español: "— Pícame mejor en una pata a ver si de verdad picas fuerte.",
                        nahuatl: "- Xine:chkwa ipan se noikxi tla: neliya chkawak tite:kwa.",
                        otomi: nil,
                        totonaco: nil),
                    Texto(
                        español: "El alacrán molesto le picó una pata, pero el zanete le dijo:",
                        nahuatl: "Nopa ko:lotl mosisinitok kikwahi ipan iikx pero no:pa tsana kilihi:",
                        otomi: nil,
                        totonaco: nil),
                    Texto(
                        español: "— No sentí nada, mejor ya come, ya no estés sufriendo.",
                        nahuatl: "- Axtle:n nimachilihi, mejor xitlakwaya, ayohana xitlaihyowi.",
                        otomi: nil,
                        totonaco: nil),
                    Texto(
                        español: "Y el alacrán empezó a comer de su pata.",
                        nahuatl: "Iwan nopa kolotl pehi kikwa ikxi nopa tsana.",
                        otomi: nil,
                        totonaco: nil),
                    Texto(
                        español: "Ya mero terminaba cuando el zanete voló hasta la rama de un árbol mientras chillaba fuertemente porque los piquetes del alacrán habían sido tremendos.",
                        nahuatl: "Kema tlaniyaya nopa tsana patlantehi iean mosewito imakayo se kwawitl iwan tsatsiyaya chikawak, pampa no:pa ite:nkokoyo nopa ko:lotl temahmati chikawak.",
                        otomi: nil,
                        totonaco: nil),
                    Texto(
                        español: "Es por eso que por donde anda el zanete se oyen claramente sus chillidos.",
                        nahuatl: "Yeka kampanemi nopa tsana mokaki kwalli itsatsilis.",
                        otomi: nil,
                        totonaco: nil),
                    Texto(
                        español: "Fuerte fue el piquete de verdad, pero el zanete salvó al hombre de este mundo de morir picado por el alacrán",
                        nahuatl: "Tlawel chikawak kikwahi pero nopa tsana kimanawihi nopa tlakatl ipan no:pa tlaltepaktli para axmikis.",
                        otomi: nil,
                        totonaco: nil)
                ],
                imagen: "alacran_y_zanate"
            ),
            Historia(titulo_español: "El conejo en la luna",
                     titulo_nahuatl: "Tochin in metztic",
                     titulo_otomi: nil,
                     titulo_totonaco: nil,
                     cultura_origen: "nahuatl",
                     parrafos: [
                        Texto(español: "El conejo en la luna",
                              nahuatl: "Tochin in mētstik",
                              otomi: nil,
                              totonaco: nil),
                        Texto(español: "Los pájaros de la noche",
                              nahuatl: "Youaltotomej",
                              otomi: nil,
                              totonaco: nil),
                        Texto(español: "Se quedaron en su casa;",
                              nahuatl: "inchan omankej;",
                              otomi: nil,
                              totonaco: nil),
                        Texto(español: "Mucho llovía a la mitad de la noche.",
                              nahuatl: "senka kiauia youalnepantla.",
                              otomi: nil,
                              totonaco: nil),
                        Texto(español: "Cuando las nubes negras se fueron,",
                              nahuatl: "In ijkuak oyajkej in tlilmixtli,",
                              otomi: nil,
                              totonaco: nil),
                        Texto(español: "Los pájaros estuvieron revoloteando,",
                              nahuatl: "youaltotomej patlantinemij,",
                              otomi: nil,
                              totonaco: nil),
                        Texto(español: "Tal vez veían al conejo en la Luna.",
                              nahuatl: "aso kittayaj tochin in metstik.",
                              otomi: nil,
                              totonaco: nil),
                        Texto(español: "Yo pude contemplar",
                              nahuatl: "Nejuatl uel onikimittak",
                              otomi: nil,
                              totonaco: nil),
                        Texto(español: "A los pájaros de la noche",
                              nahuatl: "in youaltotomej",
                              otomi: nil,
                              totonaco: nil),
                        Texto(español: "Y también al conejo en la Luna.",
                              nahuatl: "iuan tochin in mētstik.",
                              otomi: nil,
                              totonaco: nil),
                     ],
                     imagen: "conejo_luna"),
            Historia(
                titulo_español: "El Alacrán y el Zanete",
                titulo_nahuatl: "Se ko:lotl wan se tsana",
                titulo_otomi: nil,
                titulo_totonaco: nil,
                cultura_origen: "nahuatl",
                parrafos: [
                    Texto(
                        español: "Cuando el alacrán vino al mundo, vino con la intención de matar a quien picara, pero para que ello fuera posible tenía que ayunar siete días.",
                        nahuatl: "Ke:ma nopa ko:lotl walki ipan ni: tlaltepaktli, walki para kinmiktis san ahkia kimiktis, pero para weliskiya, moneki axtlakwa chikome tonati.",
                        otomi: nil,
                        totonaco: nil),
                    Texto(
                        español: "Iba ya en el sexto día de su abstinencia, cuando volando, llegó a pararse en el suelo un zanete.",
                        nahuatl: "Yowiyaya ipan chikwase tonati axtlakwatoya, kema patlantoya asiko mosewiko ipan talli/tlaltepaktli se tsana.",
                        otomi: nil,
                        totonaco: nil),
                    Texto(
                        español: "El alacrán estaba acostado junto a una piedra y el zanete, al verlo, con miedo lo interrogó:",
                        nahuatl: "Nopa ko:lotl motekatoya seho se tetl, iwan nopa tsana, keme kiitak ika mahmawilistli kitlahtlanili:",
                        otomi: nil,
                        totonaco: nil),
                    Texto(
                        español: "— ¿Qué haces alacrancito?",
                        nahuatl: "- ¿Tle:n tichi:wa pilkolo:tsin?",
                        otomi: nil,
                        totonaco: nil),
                    Texto(
                        español: "Y el alacrán le contestó:",
                        nahuatl: "Wan ne ko:lotl kinankilihi:",
                        otomi: nil,
                        totonaco: nil),
                    Texto(
                        español: "— Pues estoy aquí ayunando",
                        nahuatl: "- San nika axnitlakwa",
                        otomi: nil,
                        totonaco: nil),
                    Texto(
                        español: "— ¿Y por qué? —le preguntó el zanete.",
                        nahuatl: "- ¿Wan kenke? Kitlatlanilihi no:pa tsana.",
                        otomi: nil,
                        totonaco: nil),
                    Texto(
                        español: "— ¡Ah! Porque a quien yo pique se tiene que morir. ",
                        nahuatl: "- ¡Ah! Pampa ahkia na: nikwa moneki mikis.",
                        otomi: nil,
                        totonaco: nil),
                    Texto(
                        español: "El zanete le dijo:",
                        nahuatl: "No:pa tsana kilihi:",
                        otomi: nil,
                        totonaco: nil),
                    Texto(
                        español: "— ¡Hummmmm…! No creo que lo logres porque eres bien chiquito.",
                        nahuatl: "- ¡Hummmm…! Axnimiktokiliya tla tichiwas, pampa tlawel tipilkwekwetsin.",
                        otomi: nil,
                        totonaco: nil),
                    Texto(
                        español: "Lo que deberías hacer es comer como yo.",
                        nahuatl: "Moneki tichiwaskiya titlakwas kewal na.",
                        otomi: nil,
                        totonaco: nil),
                    Texto(
                        español: "¡Si vieras qué contento me pongo cuando estoy lleno!",
                        nahuatl: "¡Tla timatiskiya kenihkatsa niyolpaki kema niixwitok.",
                        otomi: nil,
                        totonaco: nil),
                    Texto(
                        español: "Pero el alacrán buscaba razones y se defendía. Entonces el zanete tuvo una idea y lo instigó:",
                        nahuatl: "Pero ne: ko:lotl kitemoyaya tlamantli, wan momanawiyaya nopa tsana kipixki se tlamantli wan kitlahtlanilihi:",
                        otomi: nil,
                        totonaco: nil),
                    Texto(
                        español: "— Pícame mejor en una pata a ver si de verdad picas fuerte.",
                        nahuatl: "- Xine:chkwa ipan se noikxi tla: neliya chkawak tite:kwa.",
                        otomi: nil,
                        totonaco: nil),
                    Texto(
                        español: "El alacrán molesto le picó una pata, pero el zanete le dijo:",
                        nahuatl: "Nopa ko:lotl mosisinitok kikwahi ipan iikx pero no:pa tsana kilihi:",
                        otomi: nil,
                        totonaco: nil),
                    Texto(
                        español: "— No sentí nada, mejor ya come, ya no estés sufriendo.",
                        nahuatl: "- Axtle:n nimachilihi, mejor xitlakwaya, ayohana xitlaihyowi.",
                        otomi: nil,
                        totonaco: nil),
                    Texto(
                        español: "Y el alacrán empezó a comer de su pata.",
                        nahuatl: "Iwan nopa kolotl pehi kikwa ikxi nopa tsana.",
                        otomi: nil,
                        totonaco: nil),
                    Texto(
                        español: "Ya mero terminaba cuando el zanete voló hasta la rama de un árbol mientras chillaba fuertemente porque los piquetes del alacrán habían sido tremendos.",
                        nahuatl: "Kema tlaniyaya nopa tsana patlantehi iean mosewito imakayo se kwawitl iwan tsatsiyaya chikawak, pampa no:pa ite:nkokoyo nopa ko:lotl temahmati chikawak.",
                        otomi: nil,
                        totonaco: nil),
                    Texto(
                        español: "Es por eso que por donde anda el zanete se oyen claramente sus chillidos.",
                        nahuatl: "Yeka kampanemi nopa tsana mokaki kwalli itsatsilis.",
                        otomi: nil,
                        totonaco: nil),
                    Texto(
                        español: "Fuerte fue el piquete de verdad, pero el zanete salvó al hombre de este mundo de morir picado por el alacrán",
                        nahuatl: "Tlawel chikawak kikwahi pero nopa tsana kimanawihi nopa tlakatl ipan no:pa tlaltepaktli para axmikis.",
                        otomi: nil,
                        totonaco: nil)
                ],
                imagen: "alacran_y_zanate"
            )
        ]
    )
    
    @Published var saludo_dia: Texto
    @Published var categorias: [Categoria]
    @Published var cuentos: [Historia]
    @Published var cuentosDestacados: [Historia]

    private init(saludo_dia: Texto, categorias: [Categoria], cuentos: [Historia], cuentosDestacados: [Historia]) {
        self.saludo_dia = saludo_dia
        self.categorias = categorias
        self.cuentos = cuentos
        self.cuentosDestacados = cuentosDestacados
    }
}
