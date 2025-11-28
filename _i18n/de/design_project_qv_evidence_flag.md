<h1>Projektdesign: Qualifying Variant Evidence Standard (QV-ES)</h1>

Letztes Update: 20251123

<div class="contrib-note">
  <div class="contrib-note-content">
<p>
<strong>TLDR</strong>: Gesundheitssysteme, Forschung und Industrie können genomische Resultate nicht austauschen, weil jede Pipeline etwas anderes ausgibt. QV-ES löst dies mit einer gemeinsamen Regel­spezifikation im nationalen Massstab und einer minimalen Evidenzschicht, die jede Pipeline erzeugen und jede Institution prüfen kann.
</p>
</div>
</div>

## Warum brauche ich das?

<div style="display:grid; grid-template-columns:1fr 1fr 1fr; text-align:center; font-weight:600; margin:0 0 1rem 0;">
  <div>Klinische Wissenschaft</div>
  <div>Datenengineering</div>
  <div>Industrie</div>
</div>

<img src="/images/sga_qv_es_A.png" style="width:100%; display:block; margin:0 auto;">

<ul>
<li><strong>Ich bin klinische Wissenschaftlerin oder klinischer Wissenschaftler</strong> und möchte schnell bestätigen, ob eine gemeldete Variante zuverlässig und für Akkreditierungsstandards geeignet ist.</li>
<li><strong>Ich bin Data Engineer</strong> und möchte eine stabile Evidenzschicht, die sich sauber in meine Datensysteme integrieren lässt.</li>
<li><strong>Ich arbeite in der Industrie</strong> und möchte ein gemeinsames Ausgabeformat, das meine Methoden schützt und dennoch überprüfbar bleibt.</li>
<li><strong>Ich bin Bürgerin oder Bürger</strong> und möchte klare Resultate aus modernster Wissenschaft und Medizin, wobei meine personenbezogenen Daten respektiert werden.</li>
</ul>

## Wie wird das gelöst?

<strong>Systemname</strong>: QV Evidence Framework  
<strong>Evidenzstandard</strong>: QV Evidence Standard (QV-ES)

Der QV Evidence Standard (QV-ES) ist eine Säule eines grösseren Frameworks. Das Framework umfasst drei Komponenten: die QV-Regelspezifikation, das QV-Register und den QV-ES, der die minimale überprüfbare Evidenz für die Interpretation in der klinischen Genetik definiert. QV-Sets ermöglichen eine klare Trennung zwischen Analysevariablen und der Software, die sie nutzt.

Die Regelspezifikation definiert das YAML- oder JSON-Format, das Register speichert beide QV-Regelsätze als versionierte Objekte, und QV-ES liefert die Evidenzregeln, die Pipelines verwenden, um Ausgaben zu erzeugen, die für relationale oder Graphdatenbanken im nationalen Massstab geeignet sind, etwa PostgreSQL und RDF.

Genomanalyseanbieter liefern die Variantenresultate zur Interpretation. Um diese Resultate zu prüfen und ihnen zu vertrauen, verwendet das Framework die umgekehrte Logik: Es misst, wie viel überprüfbare Evidenz eine Interpretation ungültig macht. Private Unternehmen und öffentliche Forschung erhalten eine gemeinsame Evidenzmetrik, während interne Methoden und IP getrennt bleiben.

## Technische Dokumentation

Das Open-Source-Designdokument für dieses Projekt wurde von Switzerland Omics erstellt und ist direkt unter  
<https://docs.switzerlandomics.ch/pages/design_qv_evidence_flag> verfügbar.

<img src="https://docs.switzerlandomics.ch/pages/design_doc/images/qv_evidence_flag_2.png" width="100%">
<strong>Abbildung.</strong> Erzeugung des Evidenz-Flag-Sets am Ende der Sekundäranalyse. Jedes Flag wird direkt aus Referenzdaten und Standardprüfungen berechnet, unabhängig vom Calling-Algorithmus. Diese Flags werden in die tertiäre Interpretation übernommen, sodass Endnutzerinnen und Endnutzer die wesentliche Evidenz ohne Zugriff auf die vorgelagerte Pipeline prüfen können.

## Unser Ziel

Die SGA konzentriert sich auf die Veröffentlichung des offiziellen Leitfadenmanuskripts, das derzeit auf  
<a href="https://www.swissgenomicsassociation.ch/releases/">unserer Release-Seite</a> verfügbar ist:

* <strong>Leitfaden</strong>: Swiss Genomics Association Konsensleitfaden für evidenzbasierte genomische Varianteninterpretation bei Mendelschen Erkrankungen.\
<a href="/pages/design_project_qv_evidence_flag">About (this page)</a> | 
<a href="{{ '/assets/release/mendelian_disease_interpretation/latest/mendelian_disease_interpretation_v1.pdf' | relative_url }}" target="_blank">PDF (EN)</a> |
<a href="https://github.com/swissgenomicsassociation/mendelian_disease_interpretation">Repository</a>

