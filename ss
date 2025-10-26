<!DOCTYPE html>
<html lang="ru">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>Приглашение — Gender Party PANCHULOVI</title>
<link href="https://fonts.googleapis.com/css2?family=Patrick+Hand&display=swap" rel="stylesheet">
<style>
:root{
  --bg-gradient: linear-gradient(180deg,#d7f0ff,#ffd7e6);
  --text-color: #b18cd9; /* пастельно-фиолетовый */
}
*{margin:0;padding:0;box-sizing:border-box;}
html,body{height:100%;font-family:'Patrick Hand', cursive;background:var(--bg-gradient);overflow-x:hidden;}
.section{height:100vh;display:flex;align-items:center;justify-content:center;position:relative;text-align:center;}
.phrase{font-size:clamp(28px,6vw,56px);max-width:1000px;line-height:1.05;opacity:0;transform:translateY(50px);transition:1s;text-shadow:2px 2px 6px rgba(0,0,0,0.2);padding:0 12px;}
.phrase.show{opacity:1;transform:translateY(0);}
#p1{transform:translateY(80px);}
.map-btn{padding:6px 12px;border-radius:8px;background:linear-gradient(90deg,#ff9ac6,#6aa8ff);color:white;border:none;cursor:pointer;font-size:0.9em;margin-top:10px;}
.clouds{position:fixed;inset:0;pointer-events:none;z-index:40;overflow:visible;mix-blend-mode:screen;}
.cloud{position:absolute;background:radial-gradient(60% 60% at 30% 30%, rgba(255,255,255,0.98), rgba(250,250,255,0.95) 40%, rgba(245,245,255,0.9) 60%, rgba(245,245,255,0.85) 100%);filter:blur(10px) saturate(1.02);border-radius:999px;opacity:0.95;}
.cloud.layer-deep{filter:blur(26px) saturate(1.04);opacity:0.85}
.cloud.layer-mid{filter:blur(16px);opacity:0.95}
.cloud.layer-front{filter:blur(6px);opacity:1;}
@media(max-width:720px){.phrase{font-size:clamp(20px,6vw,36px);} .cloud{filter: blur(8px);}}
</style>
</head>
<body>

<div class="clouds" id="clouds"></div>

<section class="section"><div id="p1" class="phrase">Приглашение на Gender Party PANCHULOVI</div></section>
<section class="section"><div id="p2" class="phrase">Он или Она?</div></section>
<section class="section"><div id="p3" class="phrase">Торжество произайдет в месте празднования нашего самого счастливого дня в жизни<br>Если вы не догадались, вот вам координаты: 47.8379967, 35.1767971<br><button class="map-btn" onclick="openMap()">Посмотреть на карте</button></div></section>
<section class="section"><div id="p4" class="phrase">Вам наверное интересно когда именно это произайдет</div></section>
<section class="section"><div id="p5" class="phrase">Ну тогда вот: 31.10.2025</div></section>
<section class="section"><div id="p6" class="phrase">Вам стоит быть на месте уже в 16:00</div></section>
<section class="section"><div id="p7" class="phrase">Берите с собой хорошее настроение и приходите разделить с нами этот таинственный праздник</div></section>

<audio id="bgAudio" src="music.mp3" autoplay loop></audio>

<script>
function openMap(){window.open('https://www.google.com/maps/search/?api=1&query=47.8379967,35.1767971','_blank');}

// Создание облаков
const cloudSpecs=[[900,0.36,-60,-180,'layer-deep',0.02],[700,0.34,40,10,'layer-deep',0.03],[1100,0.4,-30,200,'layer-deep',0.015],[680,0.36,120,-80,'layer-mid',0.04],[520,0.36,260,120,'layer-mid',0.05],[800,0.38,340,300,'layer-mid',0.03],[420,0.5,520,-100,'layer-front',0.06],[360,0.45,640,140,'layer-front',0.07],[540,0.44,780,360,'layer-front',0.05]];
const cloudsContainer=document.getElementById('clouds');
const clouds=[];
cloudSpecs.forEach(s=>{
  const c=document.createElement('div');
  c.className='cloud '+s[4];
  c.style.width=s[0]+'px';
  c.style.height=Math.round(s[0]*s[1])+'px';
  c.style.top=s[2]+'px';
  c.style.left=s[3]+'px';
  c.dataset.speed=s[5];
  cloudsContainer.appendChild(c);
  clouds.push(c);
});

let last=performance.now();
function animateClouds(now){
  const dt=(now-last)/1000; last=now;
  clouds.forEach(c=>{
    let L=parseFloat(c.style.left)||0;
    let sp=parseFloat(c.dataset.speed);
    L+=sp*60*dt*1.2;
    if(L>window.innerWidth+600)L=-800-Math.random()*200;
    c.style.left=L+'px';
  });
  requestAnimationFrame(animateClouds);
}
requestAnimationFrame(animateClouds);

function parallax(){
  const scroll=window.scrollY||0;
  clouds.forEach(c=>{
    const depth=c.classList.contains('layer-front')?1:(c.classList.contains('layer-mid')?0.55:0.28);
    c.style.transform='translateY('+(scroll*depth*0.12)+'px)';
  });
}
window.addEventListener('scroll',parallax);

// Появление текста
const phrases=document.querySelectorAll('.phrase');
const io=new IntersectionObserver(entries=>{
  entries.forEach(e=>{if(e.isIntersecting)e.target.classList.add('show');});
},{threshold:0.35});
phrases.forEach(p=>io.observe(p));

// Аудио автозапуск
const audio=document.getElementById('bgAudio');
function tryPlayAudio(){audio.play().catch(()=>{});}
tryPlayAudio();
function resumeAudio(){audio.play().catch(()=>{});window.removeEventListener('touchstart',resumeAudio);window.removeEventListener('mousemove',resumeAudio);window.removeEventListener('keydown',resumeAudio);}
window.addEventListener('touchstart',resumeAudio,{passive:true});
window.addEventListener('mousemove',resumeAudio,{passive:true});
window.addEventListener('keydown',resumeAudio,{passive:true});
</script>

</body>
</html>
