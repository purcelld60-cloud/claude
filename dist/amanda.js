/* Jantar da Amanda. O relógio e os controles são os das atividades da campanha. */
(() => {
  'use strict';
  const courses = [
    {
      name: 'Entrada', thought: 'E se eu derrubar o copo logo na entrada?',
      prompt: 'Amanda ajeita a gola. “Eu mesma pintei essas manchas. Adivinha onde testei a tinta?”',
      answers: [
        ['No sofá? Conta essa história.', true, '“Na almofada favorita de mãe! Agora ela tem uma almofada de onça.” Os dois caem na risada.'],
        ['Pera, deixa eu adivinhar dez vezes!', false, '“Eu conto quando você parar pra ouvir, sô.” Amanda passa o cestinho de pão.']
      ]
    },
    {
      name: 'Prato principal', thought: 'Ensaiar uma cantada ou só conversar?',
      prompt: 'Chega a moqueca. Amanda pergunta baixinho. “Você ensaiou o que ia dizer hoje?”',
      answers: [
        ['Só umas quarenta cantadas. Lá vai!', false, 'Na terceira rima com moqueca, até Da Roça perde o fio. Amanda oferece mais farofa.'],
        ['Ensaiei. Aí te vi e esqueci tudo.', true, '“Ainda bem. Eu vim jantar com você, não com o seu discurso.” Ela chega a cadeira mais perto.']
      ]
    },
    {
      name: 'Sobremesa', thought: 'Um pedaço de bolo, duas colheres. E agora?',
      prompt: 'Amanda parte o bolo de cacau. “A pontinha tem o dobro de cobertura. Como a gente resolve?”',
      answers: [
        ['Duas colheres. A gente divide!', true, 'As colheres se encontram no meio. “Até que você divide bem pra quem atravessou Itabuna por um bolo.”'],
        ['Vou chamar o Mota pra tirar no pênalti.', false, '“Num jantar pra dois você quer escalar o Mota?” Da Roça guarda o celular e os dois riem.']
      ]
    }
  ];
  const band = { start: .30, end: .70 };
  function invitation(q) {
    if (q.amandaDating) return [
      { name: 'Amanda', text: q.jaglionClaimed ? 'Olha o meu par da selva! Ainda cabe um jantar nessa agenda de herói?' : 'Deixei um presente com o Davi na Bigodon. E a nossa mesa continua lá, viu?' },
      { name: 'Amanda', text: 'Se quiser repetir a sobremesa, vem comigo.', actionLabel: 'Jantar de novo' }
    ];
    if (q.amandaInvited) return [
      { name: 'Amanda', text: 'Guardei a mesa da janela. Hoje a gente vai no nosso tempo. Bora?', actionLabel: 'Ir ao jantar' }
    ];
    return [
      { name: 'Amanda', text: 'Ei, chapéu! Vai passar correndo ou vai reparar no meu casaco? Pintei cada pintinha à mão.' },
      'Reparei, uai. Só tô tentando lembrar como é que conversa sem sair fala de missão.',
      { name: 'Amanda', text: 'Então começa com “bora jantar?”. Conheço uma varanda com a melhor moqueca da praça.', actionLabel: 'Aceitar o convite' }
    ];
  }
  function create(options) {
    return { kind: 'dinner', options, time: 0, course: 0, phase: 'breath', phaseTime: 0,
      marker: 0, misses: 0, calm: false, score: 0, feedback: '', cooldown: .22, done: false, success: false };
  }
  function changePhase(s, phase) {
    s.phase = phase;
    s.phaseTime = 0;
    s.cooldown = .22;
  }
  function update(s, dt) {
    if (s.done) return;
    s.time += dt;
    s.phaseTime += dt;
    s.cooldown = Math.max(0, s.cooldown - dt);
    if (s.phase === 'breath') {
      const period = 3.8 - s.course * .25;
      s.marker = (1 - Math.cos(s.phaseTime * 2 * Math.PI / period)) / 2;
    }
  }
  function submit(s, value) {
    if (s.done || s.cooldown > 0) return false;
    if (s.phase === 'choice') {
      if (!Number.isInteger(value)) return false;
      const answer = courses[s.course].answers[value];
      if (!answer) return false;
      if (s.calm && answer[1]) s.score++;
      s.feedback = answer[2];
      changePhase(s, 'reply');
      return true;
    }
    if (value !== undefined) return false;
    if (s.phase === 'breath') {
      s.calm = s.marker >= band.start && s.marker <= band.end;
      if (!s.calm && ++s.misses < 2) {
        s.feedback = '“Sem pressa, chapéu.” Espere o coração chegar ao bordado claro e respire.';
        s.cooldown = .42;
        return true;
      }
      changePhase(s, 'choice');
    } else if (s.phase === 'reply') {
      if (s.course === courses.length - 1) changePhase(s, 'outcome');
      else {
        s.course++;
        s.calm = false;
        s.misses = 0;
        s.marker = 0;
        s.feedback = '';
        changePhase(s, 'breath');
      }
    } else if (s.phase === 'outcome') {
      s.done = true;
      s.success = s.score >= 2;
    } else return false;
    return true;
  }
  function view(s) {
    const course = courses[s.course];
    const v = { title: 'Varanda do Cacau', scoreLabel: course.name + ' · Sintonia ' + s.score + '/3 · Meta 2',
      speaker: 'Da Roça', text: '', actionLabel: '', choices: null };
    if (s.phase === 'breath') {
      v.text = s.feedback || course.thought + ' Respire quando o coração entrar na faixa clara.';
      v.actionLabel = 'Respirar';
    } else if (s.phase === 'choice') {
      v.speaker = 'Amanda';
      v.text = course.prompt;
      v.choices = course.answers.map(([label], value) => ({ label, value }));
    } else if (s.phase === 'reply') {
      v.speaker = 'À mesa';
      v.text = s.feedback;
      v.actionLabel = s.course === courses.length - 1 ? 'Ouvir Amanda' : 'Próximo prato';
    } else {
      v.speaker = 'Amanda';
      if (s.score >= 2 && !s.options.dating) {
        v.text = '“Eu queria te ver de novo até nos dias em que ninguém roubar bolo nenhum. Quer namorar comigo?”';
        v.actionLabel = 'Quero namorar!';
      } else {
        v.text = s.options.dating ? '“Gosto de ter uma mesa nossa. Da próxima vez, a sobremesa é por minha conta.”' :
          '“Hoje a gente se atropelou um pouco, né? Outro dia a gente tenta de novo. Me encontra na praça.”';
        v.actionLabel = 'Voltar à praça';
      }
    }
    return v;
  }
  window.AmandaDinner = Object.freeze({ invitation, create, update, submit, view, band: Object.freeze(band) });
})();
