<h1>Progettazione del progetto: Qualifying Variant Evidence Standard (QV-ES)</h1>

Ultimo aggiornamento: 20251123

<div class="contrib-note">
  <div class="contrib-note-content">
<p>
<strong>TLDR</strong>: I sistemi sanitari, la ricerca e l’industria non possono scambiarsi risultati genomici perché ogni pipeline produce output differenti. QV-ES risolve questo problema con una specifica di regole condivisa a livello nazionale e uno strato minimo di evidenza che ogni pipeline può generare e che ogni istituzione può verificare.
</p>
</div>
</div>

## Perché ne ho bisogno?

<div style="display:grid; grid-template-columns:1fr 1fr 1fr; text-align:center; font-weight:600; margin:0 0 1rem 0;">
  <div>Scienza clinica</div>
  <div>Ingegneria dei dati</div>
  <div>Industria</div>
</div>

<img src="/images/sga_qv_es_A.png" style="width:100%; display:block; margin:0 auto;">

<ul>
<li><strong>Sono una scienziata o uno scienziato clinico</strong> e voglio confermare rapidamente se una variante riportata è affidabile e conforme agli standard di accreditamento.</li>
<li><strong>Sono una o un data engineer</strong> e voglio uno strato di evidenza stabile che si integri facilmente con i miei sistemi di dati.</li>
<li><strong>Lavoro nell’industria</strong> e voglio un formato di output condiviso che protegga i miei metodi e rimanga comunque verificabile.</li>
<li><strong>Sono una cittadina o un cittadino</strong> e voglio risultati chiari dalla scienza e dalla medicina avanzata, con pieno rispetto dei miei dati personali.</li>
</ul>

## Come viene risolto?

<strong>Nome del sistema</strong>: QV Evidence Framework  
<strong>Standard di evidenza</strong>: QV Evidence Standard (QV-ES)

Il QV Evidence Standard (QV-ES) è uno dei pilastri di un framework più ampio. Il framework comprende tre componenti: la specifica delle regole QV, il registro QV e il QV-ES, che definisce l’evidenza minima verificabile necessaria per l’interpretazione genetica clinica. Gli insiemi QV permettono di separare chiaramente le variabili dell’analisi genetica dal software che le utilizza.

La specifica delle regole fornisce il formato YAML o JSON, il registro conserva gli insiemi di regole QV come oggetti versionati, e QV-ES definisce le regole di evidenza che le pipeline utilizzano per produrre output adatti a database relazionali o a grafo su scala nazionale, come PostgreSQL e RDF.

I fornitori di analisi del genoma generano i risultati delle varianti per l’interpretazione. Per verificarli e fidarsi di tali risultati, il framework applica una logica inversa: misura quanta evidenza verificabile invaliderebbe una interpretazione. Le aziende private e la ricerca pubblica ottengono così una metrica di evidenza condivisa, mantenendo separate le metodologie e la proprietà intellettuale interne.

## Documentazione tecnica

Il documento di progettazione open source per questo progetto è stato preparato da Switzerland Omics ed è disponibile all’indirizzo:  
<https://docs.switzerlandomics.ch/pages/design_qv_evidence_flag>.

<img src="https://docs.switzerlandomics.ch/pages/design_doc/images/qv_evidence_flag_2.png" width="100%">
<strong>Figura.</strong> Generazione dell’insieme di flag di evidenza al termine dell’analisi secondaria. Ogni flag è calcolato direttamente dai dati di riferimento e dai controlli standard, indipendentemente dall’algoritmo di chiamata. Questi flag sono poi trasmessi all’interpretazione terziaria affinché gli utenti finali possano verificare l’evidenza essenziale senza accedere alla pipeline a monte.

## Il nostro obiettivo

La SGA si concentra sulla pubblicazione del manoscritto ufficiale delle linee guida, attualmente disponibile sulla  
<a href="https://www.swissgenomicsassociation.ch/releases/">nostra pagina delle release</a>:

* <strong>Linee guida</strong>: Linee guida di consenso della Swiss Genomics Association per l’interpretazione delle varianti genomiche basata sull’evidenza nelle malattie mendeliane.\
<a href="/pages/design_project_qv_evidence_flag">About (this page)</a> | 
<a href="{{ '/assets/release/mendelian_disease_interpretation/latest/mendelian_disease_interpretation_v1.pdf' | relative_url }}" target="_blank">PDF (EN)</a> |
<a href="https://github.com/swissgenomicsassociation/mendelian_disease_interpretation">Repository</a>

