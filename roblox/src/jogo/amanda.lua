--!nocheck
local __JSR = require(script.Parent.Parent.runtime.js)
local window = __JSR.window
local tostring = __JSR.__str
local __le, __gt, __ge, __isInteger, __ord, __arrL, __t, __get, __len, __call, __add = __JSR.__le, __JSR.__gt, __JSR.__ge, __JSR.__isInteger, __JSR.__ord, __JSR.__arrL, __JSR.__t, __JSR.__get, __JSR.__len, __JSR.__call, __JSR.__add
local ____exports = {};
(function()
    local ____ = "use strict"
    local courses = __arrL(
        {
            __ord(
                {
                    name = "Entrada",
                    thought = "E se eu derrubar o copo logo na entrada?",
                    prompt = "Amanda ajeita a gola. “Eu mesma pintei essas manchas. Adivinha onde testei a tinta?”",
                    answers = __arrL(
                        {
                            __arrL({"No sofá? Conta essa história.", true, "“Na almofada favorita de mãe! Agora ela tem uma almofada de onça.” Os dois caem na risada."}, 3),
                            __arrL({"Pera, deixa eu adivinhar dez vezes!", false, "“Eu conto quando você parar pra ouvir, sô.” Amanda passa o cestinho de pão."}, 3)
                        },
                        2
                    )
                },
                "name,thought,prompt,answers"
            ),
            __ord(
                {
                    name = "Prato principal",
                    thought = "Ensaiar uma cantada ou só conversar?",
                    prompt = "Chega a moqueca. Amanda pergunta baixinho. “Você ensaiou o que ia dizer hoje?”",
                    answers = __arrL(
                        {
                            __arrL({"Só umas quarenta cantadas. Lá vai!", false, "Na terceira rima com moqueca, até Da Roça perde o fio. Amanda oferece mais farofa."}, 3),
                            __arrL({"Ensaiei. Aí te vi e esqueci tudo.", true, "“Ainda bem. Eu vim jantar com você, não com o seu discurso.” Ela chega a cadeira mais perto."}, 3)
                        },
                        2
                    )
                },
                "name,thought,prompt,answers"
            ),
            __ord(
                {
                    name = "Sobremesa",
                    thought = "Um pedaço de bolo, duas colheres. E agora?",
                    prompt = "Amanda parte o bolo de cacau. “A pontinha tem o dobro de cobertura. Como a gente resolve?”",
                    answers = __arrL(
                        {
                            __arrL({"Duas colheres. A gente divide!", true, "As colheres se encontram no meio. “Até que você divide bem pra quem atravessou Itabuna por um bolo.”"}, 3),
                            __arrL({"Vou chamar o Mota pra tirar no pênalti.", false, "“Num jantar pra dois você quer escalar o Mota?” Da Roça guarda o celular e os dois riem."}, 3)
                        },
                        2
                    )
                },
                "name,thought,prompt,answers"
            )
        },
        3
    )
    local band = __ord({start = 0.3, ["end"] = 0.7}, "start,end")
    local function invitation(self, q)
        if __t(q.amandaDating) then
            return __arrL(
                {
                    {
                        name = "Amanda",
                        text = __t(q.jaglionClaimed) and "Olha o meu par da selva! Ainda cabe um jantar nessa agenda de herói?" or "Deixei um presente com o Davi na Bigodon. E a nossa mesa continua lá, viu?"
                    },
                    {name = "Amanda", text = "Se quiser repetir a sobremesa, vem comigo.", actionLabel = "Jantar de novo"}
                },
                2
            )
        end
        if __t(q.amandaInvited) then
            return __arrL({{name = "Amanda", text = "Guardei a mesa da janela. Hoje a gente vai no nosso tempo. Bora?", actionLabel = "Ir ao jantar"}}, 1)
        end
        return __arrL({{name = "Amanda", text = "Ei, chapéu! Vai passar correndo ou vai reparar no meu casaco? Pintei cada pintinha à mão."}, "Reparei, uai. Só tô tentando lembrar como é que conversa sem sair fala de missão.", {name = "Amanda", text = "Então começa com “bora jantar?”. Conheço uma varanda com a melhor moqueca da praça.", actionLabel = "Aceitar o convite"}}, 3)
    end
    local function create(self, options)
        return {
            kind = "dinner",
            options = options,
            time = 0,
            course = 0,
            phase = "breath",
            phaseTime = 0,
            marker = 0,
            misses = 0,
            calm = false,
            score = 0,
            feedback = "",
            cooldown = 0.22,
            done = false,
            success = false
        }
    end
    local function changePhase(self, s, phase)
        s.phase = phase
        s.phaseTime = 0
        s.cooldown = 0.22
    end
    local function update(self, s, dt)
        if __t(s.done) then
            return
        end
        s.time = __add(s.time, dt)
        s.phaseTime = __add(s.phaseTime, dt)
        s.cooldown = math.max(0, s.cooldown - dt)
        if s.phase == "breath" then
            local period = 3.8 - s.course * 0.25
            s.marker = (1 - math.cos(s.phaseTime * 2 * math.pi / period)) / 2
        end
    end
    local function submit(self, s, value)
        local ____t_1 = __t
        local ____t_result_0
        if __t(s.done) then
            ____t_result_0 = s.done
        else
            ____t_result_0 = __gt(s.cooldown, 0)
        end
        if ____t_1(____t_result_0) then
            return false
        end
        if s.phase == "choice" then
            if not __isInteger(value) then
                return false
            end
            local answer = __get(
                __get(courses, s.course).answers,
                value
            )
            if not __t(answer) then
                return false
            end
            local ____t_3 = __t
            local ____t_result_2
            if __t(s.calm) then
                ____t_result_2 = __get(answer, 1)
            else
                ____t_result_2 = s.calm
            end
            if ____t_3(____t_result_2) then
                s.score = s.score + 1
            end
            s.feedback = __get(answer, 2)
            changePhase(nil, s, "reply")
            return true
        end
        if value ~= nil then
            return false
        end
        if s.phase == "breath" then
            s.calm = __ge(s.marker, band.start) and __le(s.marker, band["end"])
            local ____t_8 = __t
            local ____temp_7 = not __t(s.calm)
            if ____temp_7 then
                local ____s_4, ____misses_5 = s, "misses"
                local ____s_misses_6 = ____s_4[____misses_5] + 1
                ____s_4[____misses_5] = ____s_misses_6
                ____temp_7 = ____s_misses_6 < 2
            end
            if ____t_8(____temp_7) then
                s.feedback = "“Sem pressa, chapéu.” Espere o coração chegar ao bordado claro e respire."
                s.cooldown = 0.42
                return true
            end
            changePhase(nil, s, "choice")
        elseif s.phase == "reply" then
            if s.course == __len(courses) - 1 then
                changePhase(nil, s, "outcome")
            else
                s.course = s.course + 1
                s.calm = false
                s.misses = 0
                s.marker = 0
                s.feedback = ""
                changePhase(nil, s, "breath")
            end
        elseif s.phase == "outcome" then
            s.done = true
            s.success = __ge(s.score, 2)
        else
            return false
        end
        return true
    end
    local function view(self, s)
        local course = __get(courses, s.course)
        local v = {
            title = "Varanda do Cacau",
            scoreLabel = __add(
                __add(
                    __add(course.name, " · Sintonia "),
                    s.score
                ),
                "/3 · Meta 2"
            ),
            speaker = "Da Roça",
            text = "",
            actionLabel = "",
            choices = nil
        }
        if s.phase == "breath" then
            local ____t_result_9
            if __t(s.feedback) then
                ____t_result_9 = s.feedback
            else
                ____t_result_9 = __add(course.thought, " Respire quando o coração entrar na faixa clara.")
            end
            v.text = ____t_result_9
            v.actionLabel = "Respirar"
        elseif s.phase == "choice" then
            v.speaker = "Amanda"
            v.text = course.prompt
            v.choices = __call(
                course.answers,
                "map",
                function(____, ____bindingPattern0, value)
                    local label
                    label = ____bindingPattern0[1]
                    return {label = label, value = value}
                end
            )
        elseif s.phase == "reply" then
            v.speaker = "À mesa"
            v.text = s.feedback
            v.actionLabel = s.course == __len(courses) - 1 and "Ouvir Amanda" or "Próximo prato"
        else
            v.speaker = "Amanda"
            if __t(__ge(s.score, 2) and not __t(s.options.dating)) then
                v.text = "“Eu queria te ver de novo até nos dias em que ninguém roubar bolo nenhum. Quer namorar comigo?”"
                v.actionLabel = "Quero namorar!"
            else
                v.text = __t(s.options.dating) and "“Gosto de ter uma mesa nossa. Da próxima vez, a sobremesa é por minha conta.”" or "“Hoje a gente se atropelou um pouco, né? Outro dia a gente tenta de novo. Me encontra na praça.”"
                v.actionLabel = "Voltar à praça"
            end
        end
        return v
    end
    window.AmandaDinner = __ord({
        invitation = invitation,
        create = create,
        update = update,
        submit = submit,
        view = view,
        band = band
    }, "invitation,create,update,submit,view,band")
end)(nil)
return ____exports
