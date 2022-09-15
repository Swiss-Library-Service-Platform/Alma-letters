<?xml version="1.0" encoding="utf-8"?>
<xsl:stylesheet version="1.0"
	xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
	<xsl:include href="header.xsl" />
	<xsl:include href="senderReceiver.xsl" />
	<xsl:include href="mailReason.xsl" />
	<xsl:include href="style.xsl" />
	<xsl:include href="recordTitle.xsl" />
	<xsl:template match="/">
		<html>

			<head>
				<title>
					<xsl:value-of select="notification_data/general_data/subject"/>
				</title>

				<xsl:call-template name="generalStyle" />
			</head>
			<body>
				<xsl:attribute name="style">
					<xsl:call-template name="bodyStyleCss" />
					<!-- style.xsl -->
				</xsl:attribute>
				<xsl:call-template name="head" />
				<!-- header.xsl -->

	<!--TO -->
										<table role="presentation">
											<tr>
												<td align="left">
													@@Dear@@
														<xsl:value-of select="/notification_data/receivers/receiver/user/first_name" />
                                                                                   <td align="left" style="padding-left: 1px;">
														<xsl:value-of select="/notification_data/receivers/receiver/user/last_name" />,
									
                                                                                            </td>
                                                                                           </td>
											</tr>
										</table>
										<!--END TO -->

				<div class="messageArea">
					<div class="messageBody">

		
								
								<xsl:if test="notification_data/notification_type = 'NOTIFY_PATRONS_SLSP_MIGRATION' ">

</xsl:if>
<xsl:template name="multilingual">
		<xsl:choose>
	<xsl:when test="//preferred_language='de'">
<table role='presentation'  cellspacing="0" cellpadding="5" border="0" style="width:60%">	
	<tr> 				
				<td> 
Version 1.2: adjusted line width / resized headings / fixed salutation spaces / changed line intend for headings and text blocks / fixed link to <i>Gebühren</i> 
 / force font Arial sans-serife<br/>	
***Your account is <strong style="color: #ff9933;">German?</strong> Well done!***
				</td> 				
				</tr> 	
		         <tr> 				
				<td align="left">
Die Bibliothek am Guisanplatz BiG und der Bibliotheksverbund Alexandria schliessen sich per 11. April 2022 dem schweizweiten Bibliotheksnetzwerk SLSP (Swiss Library Service Plattform) an. Für die Nutzerinnen und Nutzer hat dies weitreichende Folgen, über die wir Sie hiermit gerne informieren.
				</td> 				
				</tr> 
				  <tr> 				
				<td align="left" style="font-size:18px;padding-bottom: 10px;">
<strong> 1.	Neue Suchoberfläche und neues Rechercheportal </strong>
                 </td> 				
				</tr> 
				 <tr> 				
			<td align="left" style="padding-left: 24px;">
Das Rechercheportal Alexandria (<a href="https://www.alexandria.ch">www.alexandria.ch</a>) bietet ab dem 11. April 2022 neben dem Medienbestand des Verbunds über die Suchoberfläche swisscovery auch einen Zugriff auf den Grossteil des wissenschaftlichen Medienbestands der Schweiz (über 475 Bibliotheken).
                  </td> 				
				</tr> 
				<tr> 				
				<td align="left" style="font-size:18px;padding-bottom: 10px;">
<strong> 2.	Selbständige Neuregistration für alle Nutzerinnen und Nutzer</strong>
                               </td> 				
				</tr> 
				 <tr> 				
				<td align="left" style="padding-left: 24px;">
Um ab dem 11. April 2022 weiterhin über das Rechercheportal Alexandria Medien bestellen und ausleihen zu können, ist eine Neuregistrierung bei SLSP zwingend erforderlich. Ein SWITCH edu-ID Konto wiederum ist die Voraussetzung, um sich bei SLSP registrieren zu können. 
                                          </td> 				
				</tr> 
				<tr> 	
               <td style="color:red;padding-left: 24px;"> <strong>
Aus Datenschutzgründen muss die Registration selbst vorgenommen werden. Bestehende Benutzerkonten werden gelöscht und nicht übernommen.
                             </strong>
                              </td> 				
				</tr> 
				 <tr> 				
				<td align="left" style="padding-left: 24px;">
         Mitarbeitenden von Bundesverwaltung oder Armee wird empfohlen, sich mit der beruflichen Adresse zu registrieren. Melden Sie sich nach erfolgter 
        Registrierung per Mail bei bibliothek@gs-vbs.admin.ch, um der entsprechenden Kundengruppe zugeteilt zu werden. So können Sie nach der Einführung 
       des neuen Portals weiterhin von den Bedingungen für Bundesmitarbeitende profitieren.
							   </td> 				
				</tr>
                             <tr> 				
				<td align="left" style="padding-left: 24px;">
<a href="https://www.big.admin.ch/">Anleitung Registrierung SLSP mit vorhandener SWITCH edu-ID (PDF, de)</a> <br/>
<a href="https://www.big.admin.ch/">Anleitung Registrierung SLSP ohne SWITCH edu-ID (PDF, de)</a>
                               </td> 				
				</tr> 
					<tr> 				
				<td align="left" style="font-size:18px;padding-bottom: 10px;">
<strong> 3.	Einschränkungen im Ausleihbetrieb</strong>
                                        </td> 				
				</tr> 
                            <tr> 				
			<td align="left" style="padding-left: 24px;">
Damit die Umstellung auf das neue Rechercheportal reibungslos funktioniert, wird es einige
Einschränkungen im Ausleihbetrieb geben:
      </td> 				
				</tr>                                     

<tr> 				
				<td align="left" style="padding-left: 24px;">
<strong>Keine Fernleihbestellungen zwischen dem 1. März und 11. April 2022</strong><br/>
Der interbibliothekarische Leihverkehr wird vorübergehend eingestellt. Benutzerinnen und Benutzer werden gebeten, sämtliche über die Fernleihe bestellten Medien bis zum <strong>25. März 2022</strong> zurückzubringen.
                                </td> 				
				</tr> 
                             <tr> 				
				<td align="left" style="padding-left: 24px;">
<strong>Rückruf sämtlicher ausgeliehenen Medien bis 25. März 2022</strong><br/>
Alle Nutzerinnen und Nutzer sind angehalten, sämtliche Medien bis spätestens am <strong>25. März 2022</strong> zurückzugeben. Sie können ab dem 11. April 2022 nach Erstellung des Kontos erneut vor Ort oder via Post/Kurier ausgeliehen werden.
                                    </td> 				
				</tr> 
                                         <tr> 				
				<td align="left" style="padding-left: 24px;">
<strong>Keine Ausleihe, keine Rückgabe und keine Verlängerung zwischen 25. März und 11. April 2022:</strong><br/>
Der Ausleihbetrieb wird während der Migration vorübergehend eingestellt. Es können keine Ausleihen, Rückgaben oder Verlängerungen getätigt werden – weder im alten noch im neuen System.
                                   </td> 				
				</tr> 
                                          <tr> 				
				<td align="left" style="padding-left: 24px;"> 
Am 11. April 2022 geht das neue Rechercheportal unter <a href="https://www.alexandria.ch">www.alexandria.ch</a> online: Ausleihen sind nach erfolgter Registrierung (siehe Punkt 2) wieder möglich.
                                      </td> 				
				</tr> 
                        
                                                  <tr> 				
			<td align="left" style="padding-left: 24px;">
<strong>Löschung Reservationen und Favoriten</strong><br/>
Bestehende Reservationen auf ausgeliehene Medien werden gelöscht. Am besten notieren Sie sich die reservierten Medien, um sie nach dem 11. April 2022 erneut reservieren zu können.
                                           </td> 				
				</tr> 
				<tr> 				
				<td align="left" style="font-size:18px;padding-bottom: 10px;">
<strong> 4.	Neue Gebührenordnung</strong> <br/>
                                             </td> 				
				</tr>
<tr> 				
				<td align="left" style="padding-left: 24px;"> 
Mit dem Übergang zu SLSP führt die BiG am 11. April 2022 eine <a href="https://www.big.admin.ch/">Gebührenordnung</a> ein, die für Privatpersonen mit neuen Gebühren 
(Digitalisierungsaufträge/Mahnungen) verbunden ist.
              </td> 				
				</tr>
                                                     <tr> 				
				<td align="left" style="padding-left: 24px;">
Bundesmitarbeitende können nach erfolgter Registrierung weiterhin kostenlos von den Dienstleistungen der BiG profitieren, sofern sie nach dem 11. April 2022 der entsprechenden Kundengruppe zugeteilt wurden. Melden Sie sich hierzu per Mail bei: <a href="mailto:bibliothek@gs-vbs.admin.ch">bibliothek@gs-vbs.admin.ch</a> (siehe Punkt 2).  
                                                  </td> 				
				</tr>
                        <tr> 				
				<td align="left" style="font-size:18px;padding-bottom: 10px;">
<strong> 5. Aktuelle Informationen auf der Website der BiG</strong><br/>
                       </td> 				
				</tr>
 <tr> 				
			<td align="left" style="padding-left: 24px;"> 
Laufend aktuelle Informationen zum Übergang des Bibliotheksverbunds Alexandria zu SLSP finden Sie auf der <a href="https://www.big.admin.ch/">Website der BiG</a>.<br/>
Kontaktieren Sie uns, wir unterstützen Sie gerne und beantworten Ihre Fragen. <br/>
Freundliche Grüsse
                             </td> 				
				</tr>
                            <tr> 				
				<td align="left" style="padding-left: 24px;"> 
Bibliothek am Guisanplatz<br/>
Papiermühlestrasse 21a<br/>
CH-3003 Bern<br/>
Tel. +41 58 464 50 99<br/>
Mail: <a href="mailto:bibliothek@gs-vbs.admin.ch">bibliothek@gs-vbs.admin.ch</a>
                              </td> 				
				</tr>
				</table>
			</xsl:when>


			<xsl:when test="//preferred_language='fr'" >
	<table role='presentation'  cellspacing="0" cellpadding="5" border="0" style="width:60%">	
	<tr> 				
				<td> 
Version 1.2: adjusted line width / resized headings / fixed salutation spaces / changed line intend for headings and text blocks / fixed link to <i>Gebühren</i> 
 / force font Arial sans-serife<br/>	
***Your account is <strong style="color: #ff9933;">French?</strong> Well done!***
				</td> 				
				</tr> 	
		         <tr> 				
				<td align="left">
Die Bibliothek am Guisanplatz BiG und der Bibliotheksverbund Alexandria schliessen sich per 11. April 2022 dem schweizweiten Bibliotheksnetzwerk SLSP (Swiss Library Service Plattform) an. Für die Nutzerinnen und Nutzer hat dies weitreichende Folgen, über die wir Sie hiermit gerne informieren.
				</td> 				
				</tr> 
				  <tr> 				
				<td align="left" style="font-size:18px;padding-bottom: 10px;">
<strong> 1.	Neue Suchoberfläche und neues Rechercheportal </strong>
                 </td> 				
				</tr> 
				 <tr> 				
			<td align="left" style="padding-left: 24px;">
Das Rechercheportal Alexandria (<a href="https://www.alexandria.ch">www.alexandria.ch</a>) bietet ab dem 11. April 2022 neben dem Medienbestand des Verbunds über die Suchoberfläche swisscovery auch einen Zugriff auf den Grossteil des wissenschaftlichen Medienbestands der Schweiz (über 475 Bibliotheken).
                  </td> 				
				</tr> 
				<tr> 				
				<td align="left" style="font-size:18px;padding-bottom: 10px;">
<strong> 2.	Selbständige Neuregistration für alle Nutzerinnen und Nutzer</strong>
                               </td> 				
				</tr> 
				 <tr> 				
				<td align="left" style="padding-left: 24px;">
Um ab dem 11. April 2022 weiterhin über das Rechercheportal Alexandria Medien bestellen und ausleihen zu können, ist eine Neuregistrierung bei SLSP zwingend erforderlich. Ein SWITCH edu-ID Konto wiederum ist die Voraussetzung, um sich bei SLSP registrieren zu können. 
                                          </td> 				
				</tr> 
				<tr> 	
               <td style="color:red;padding-left: 24px;"> <strong>
Aus Datenschutzgründen muss die Registration selbst vorgenommen werden. Bestehende Benutzerkonten werden gelöscht und nicht übernommen.
                             </strong>
                              </td> 				
				</tr> 
				 <tr> 				
				<td align="left" style="padding-left: 24px;">
         Mitarbeitenden von Bundesverwaltung oder Armee wird empfohlen, sich mit der beruflichen Adresse zu registrieren. Melden Sie sich nach erfolgter 
        Registrierung per Mail bei bibliothek@gs-vbs.admin.ch, um der entsprechenden Kundengruppe zugeteilt zu werden. So können Sie nach der Einführung 
       des neuen Portals weiterhin von den Bedingungen für Bundesmitarbeitende profitieren.
							   </td> 				
				</tr>
                             <tr> 				
				<td align="left" style="padding-left: 24px;">
<a href="https://www.big.admin.ch/">Anleitung Registrierung SLSP mit vorhandener SWITCH edu-ID (PDF, de)</a> <br/>
<a href="https://www.big.admin.ch/">Anleitung Registrierung SLSP ohne SWITCH edu-ID (PDF, de)</a>
                               </td> 				
				</tr> 
					<tr> 				
				<td align="left" style="font-size:18px;padding-bottom: 10px;">
<strong> 3.	Einschränkungen im Ausleihbetrieb</strong>
                                        </td> 				
				</tr> 
                            <tr> 				
			<td align="left" style="padding-left: 24px;">
Damit die Umstellung auf das neue Rechercheportal reibungslos funktioniert, wird es einige
Einschränkungen im Ausleihbetrieb geben:
      </td> 				
				</tr>                                     

<tr> 				
				<td align="left" style="padding-left: 24px;">
<strong>Keine Fernleihbestellungen zwischen dem 1. März und 11. April 2022</strong><br/>
Der interbibliothekarische Leihverkehr wird vorübergehend eingestellt. Benutzerinnen und Benutzer werden gebeten, sämtliche über die Fernleihe bestellten Medien bis zum <strong>25. März 2022</strong> zurückzubringen.
                                </td> 				
				</tr> 
                             <tr> 				
				<td align="left" style="padding-left: 24px;">
<strong>Rückruf sämtlicher ausgeliehenen Medien bis 25. März 2022</strong><br/>
Alle Nutzerinnen und Nutzer sind angehalten, sämtliche Medien bis spätestens am <strong>25. März 2022</strong> zurückzugeben. Sie können ab dem 11. April 2022 nach Erstellung des Kontos erneut vor Ort oder via Post/Kurier ausgeliehen werden.
                                    </td> 				
				</tr> 
                                         <tr> 				
				<td align="left" style="padding-left: 24px;">
<strong>Keine Ausleihe, keine Rückgabe und keine Verlängerung zwischen 25. März und 11. April 2022:</strong><br/>
Der Ausleihbetrieb wird während der Migration vorübergehend eingestellt. Es können keine Ausleihen, Rückgaben oder Verlängerungen getätigt werden – weder im alten noch im neuen System.
                                   </td> 				
				</tr> 
                                          <tr> 				
				<td align="left" style="padding-left: 24px;"> 
Am 11. April 2022 geht das neue Rechercheportal unter <a href="https://www.alexandria.ch">www.alexandria.ch</a> online: Ausleihen sind nach erfolgter Registrierung (siehe Punkt 2) wieder möglich.
                                      </td> 				
				</tr> 
                        
                                                  <tr> 				
			<td align="left" style="padding-left: 24px;">
<strong>Löschung Reservationen und Favoriten</strong><br/>
Bestehende Reservationen auf ausgeliehene Medien werden gelöscht. Am besten notieren Sie sich die reservierten Medien, um sie nach dem 11. April 2022 erneut reservieren zu können.
                                           </td> 				
				</tr> 
				<tr> 				
				<td align="left" style="font-size:18px;padding-bottom: 10px;">
<strong> 4.	Neue Gebührenordnung</strong> <br/>
                                             </td> 				
				</tr>
<tr> 				
				<td align="left" style="padding-left: 24px;"> 
Mit dem Übergang zu SLSP führt die BiG am 11. April 2022 eine <a href="https://www.big.admin.ch/">Gebührenordnung</a> ein, die für Privatpersonen mit neuen Gebühren (Digitalisierungsaufträge/Mahnungen) verbunden ist.
              </td> 				
				</tr>
                                                     <tr> 				
				<td align="left" style="padding-left: 24px;">
Bundesmitarbeitende können nach erfolgter Registrierung weiterhin kostenlos von den Dienstleistungen der BiG profitieren, sofern sie nach dem 11. April 2022 der entsprechenden Kundengruppe zugeteilt wurden. Melden Sie sich hierzu per Mail bei: <a href="mailto:bibliothek@gs-vbs.admin.ch">bibliothek@gs-vbs.admin.ch</a> (siehe Punkt 2).  
                                                  </td> 				
				</tr>
                        <tr> 				
				<td align="left" style="font-size:18px;padding-bottom: 10px;">
<strong> 5. Aktuelle Informationen auf der Website der BiG</strong><br/>
                       </td> 				
				</tr>
 <tr> 				
			<td align="left" style="padding-left: 24px;"> 
Laufend aktuelle Informationen zum Übergang des Bibliotheksverbunds Alexandria zu SLSP finden Sie auf der <a href="https://www.big.admin.ch/">Website der BiG</a>.<br/>
Kontaktieren Sie uns, wir unterstützen Sie gerne und beantworten Ihre Fragen. <br/>
Freundliche Grüsse
                             </td> 				
				</tr>
                            <tr> 				
			<td align="left" style="padding-left: 24px;"> 
Bibliothek am Guisanplatz<br/>
Papiermühlestrasse 21a<br/>
CH-3003 Bern<br/>
Tel. +41 58 464 50 99<br/>
Mail: <a href="mailto:bibliothek@gs-vbs.admin.ch">bibliothek@gs-vbs.admin.ch</a>
                              </td> 				
				</tr>
				</table>
			</xsl:when>


			<xsl:when test="//preferred_language='it'" >
<table role='presentation'  cellspacing="0" cellpadding="5" border="0" style="width:60%">	
	<tr> 				
				<td> 
Version 1.2: adjusted line width / resized headings / fixed salutation spaces / changed line intend for headings and text blocks / fixed link to <i>Gebühren</i> 
 / force font Arial sans-serife<br/>	
***Your account is <strong style="color: #ff9933;">Italian?</strong> Well done!***
				</td> 				
				</tr> 	
		         <tr> 				
				<td align="left">
Die Bibliothek am Guisanplatz BiG und der Bibliotheksverbund Alexandria schliessen sich per 11. April 2022 dem schweizweiten Bibliotheksnetzwerk SLSP (Swiss Library Service Plattform) an. Für die Nutzerinnen und Nutzer hat dies weitreichende Folgen, über die wir Sie hiermit gerne informieren.
				</td> 				
				</tr> 
				  <tr> 				
				<td align="left" style="font-size:18px;padding-bottom: 10px;">
<strong> 1.	Neue Suchoberfläche und neues Rechercheportal </strong>
                 </td> 				
				</tr> 
				 <tr> 				
			<td align="left" style="padding-left: 24px;">
Das Rechercheportal Alexandria (<a href="https://www.alexandria.ch">www.alexandria.ch</a>) bietet ab dem 11. April 2022 neben dem Medienbestand des Verbunds über die Suchoberfläche swisscovery auch einen Zugriff auf den Grossteil des wissenschaftlichen Medienbestands der Schweiz (über 475 Bibliotheken).
                  </td> 				
				</tr> 
				<tr> 				
				<td align="left" style="font-size:18px;padding-bottom: 10px;">
<strong> 2.	Selbständige Neuregistration für alle Nutzerinnen und Nutzer</strong>
                               </td> 				
				</tr> 
				 <tr> 				
				<td align="left" style="padding-left: 24px;">
Um ab dem 11. April 2022 weiterhin über das Rechercheportal Alexandria Medien bestellen und ausleihen zu können, ist eine Neuregistrierung bei SLSP zwingend erforderlich. Ein SWITCH edu-ID Konto wiederum ist die Voraussetzung, um sich bei SLSP registrieren zu können. 
                                          </td> 				
				</tr> 
				<tr> 	
               <td style="color:red;padding-left: 24px;"> <strong>
Aus Datenschutzgründen muss die Registration selbst vorgenommen werden. Bestehende Benutzerkonten werden gelöscht und nicht übernommen.
                             </strong>
                              </td> 				
				</tr> 
				 <tr> 				
				<td align="left" style="padding-left: 24px;">
         Mitarbeitenden von Bundesverwaltung oder Armee wird empfohlen, sich mit der beruflichen Adresse zu registrieren. Melden Sie sich nach erfolgter 
        Registrierung per Mail bei bibliothek@gs-vbs.admin.ch, um der entsprechenden Kundengruppe zugeteilt zu werden. So können Sie nach der Einführung 
       des neuen Portals weiterhin von den Bedingungen für Bundesmitarbeitende profitieren.
							   </td> 				
				</tr>
                             <tr> 				
				<td align="left" style="padding-left: 24px;">
<a href="https://www.big.admin.ch/">Anleitung Registrierung SLSP mit vorhandener SWITCH edu-ID (PDF, de)</a> <br/>
<a href="https://www.big.admin.ch/">Anleitung Registrierung SLSP ohne SWITCH edu-ID (PDF, de)</a>
                               </td> 				
				</tr> 
					<tr> 				
				<td align="left" style="font-size:18px;padding-bottom: 10px;">
<strong> 3.	Einschränkungen im Ausleihbetrieb</strong>
                                        </td> 				
				</tr> 
                            <tr> 				
			<td align="left" style="padding-left: 24px;">
Damit die Umstellung auf das neue Rechercheportal reibungslos funktioniert, wird es einige
Einschränkungen im Ausleihbetrieb geben:
      </td> 				
				</tr>                                     

<tr> 				
				<td align="left" style="padding-left: 24px;">
<strong>Keine Fernleihbestellungen zwischen dem 1. März und 11. April 2022</strong><br/>
Der interbibliothekarische Leihverkehr wird vorübergehend eingestellt. Benutzerinnen und Benutzer werden gebeten, sämtliche über die Fernleihe bestellten Medien bis zum <strong>25. März 2022</strong> zurückzubringen.
                                </td> 				
				</tr> 
                             <tr> 				
				<td align="left" style="padding-left: 24px;">
<strong>Rückruf sämtlicher ausgeliehenen Medien bis 25. März 2022</strong><br/>
Alle Nutzerinnen und Nutzer sind angehalten, sämtliche Medien bis spätestens am <strong>25. März 2022</strong> zurückzugeben. Sie können ab dem 11. April 2022 nach Erstellung des Kontos erneut vor Ort oder via Post/Kurier ausgeliehen werden.
                                    </td> 				
				</tr> 
                                         <tr> 				
				<td align="left" style="padding-left: 24px;">
<strong>Keine Ausleihe, keine Rückgabe und keine Verlängerung zwischen 25. März und 11. April 2022:</strong><br/>
Der Ausleihbetrieb wird während der Migration vorübergehend eingestellt. Es können keine Ausleihen, Rückgaben oder Verlängerungen getätigt werden – weder im alten noch im neuen System.
                                   </td> 				
				</tr> 
                                          <tr> 				
				<td align="left" style="padding-left: 24px;"> 
Am 11. April 2022 geht das neue Rechercheportal unter <a href="https://www.alexandria.ch">www.alexandria.ch</a> online: Ausleihen sind nach erfolgter Registrierung (siehe Punkt 2) wieder möglich.
                                      </td> 				
				</tr> 
                        
                                                  <tr> 				
			<td align="left" style="padding-left: 24px;">
<strong>Löschung Reservationen und Favoriten</strong><br/>
Bestehende Reservationen auf ausgeliehene Medien werden gelöscht. Am besten notieren Sie sich die reservierten Medien, um sie nach dem 11. April 2022 erneut reservieren zu können.
                                           </td> 				
				</tr> 
				<tr> 				
				<td align="left" style="font-size:18px;padding-bottom: 10px;">
<strong> 4.	Neue Gebührenordnung</strong> <br/>
                                             </td> 				
				</tr>
<tr> 				
				<td align="left" style="padding-left: 24px;"> 
Mit dem Übergang zu SLSP führt die BiG am 11. April 2022 eine <a href="https://www.big.admin.ch/">Gebührenordnung</a> ein, die für Privatpersonen mit neuen Gebühren (Digitalisierungsaufträge/Mahnungen) verbunden ist.
              </td> 				
				</tr>
                                                     <tr> 				
				<td align="left" style="padding-left: 24px;">
Bundesmitarbeitende können nach erfolgter Registrierung weiterhin kostenlos von den Dienstleistungen der BiG profitieren, sofern sie nach dem 11. April 2022 der entsprechenden Kundengruppe zugeteilt wurden. Melden Sie sich hierzu per Mail bei: <a href="mailto:bibliothek@gs-vbs.admin.ch">bibliothek@gs-vbs.admin.ch</a> (siehe Punkt 2).  
                                                  </td> 				
				</tr>
                        <tr> 				
				<td align="left" style="font-size:18px;padding-bottom: 10px;">
<strong> 5. Aktuelle Informationen auf der Website der BiG</strong><br/>
                       </td> 				
				</tr>
 <tr> 				
			<td align="left" style="padding-left: 24px;"> 
Laufend aktuelle Informationen zum Übergang des Bibliotheksverbunds Alexandria zu SLSP finden Sie auf der <a href="https://www.big.admin.ch/">Website der BiG</a>.<br/>
Kontaktieren Sie uns, wir unterstützen Sie gerne und beantworten Ihre Fragen. <br/>
Freundliche Grüsse
                             </td> 				
				</tr>
                            <tr> 				
			<td align="left" style="padding-left: 24px;"> 
Bibliothek am Guisanplatz<br/>
Papiermühlestrasse 21a<br/>
CH-3003 Bern<br/>
Tel. +41 58 464 50 99<br/>
Mail: <a href="mailto:bibliothek@gs-vbs.admin.ch">bibliothek@gs-vbs.admin.ch</a>
                              </td> 				
				</tr>
				</table>
			</xsl:when>



			<xsl:otherwise>
<table role='presentation'  cellspacing="0" cellpadding="5" border="0" style="width:60%">	
	<tr> 				
				<td> 
Version 1.2: adjusted line width / resized headings / fixed salutation spaces / changed line intend for headings and text blocks / fixed link to <i>Gebühren</i> 
 / force font Arial sans-serife<br/>	
***Hey, your account <strong style="color: #ff9933;">language </strong> could not be detected! So the text will be sent in german.***
				</td> 				
				</tr> 	
		         <tr> 				
				<td align="left">
Die Bibliothek am Guisanplatz BiG und der Bibliotheksverbund Alexandria schliessen sich per 11. April 2022 dem schweizweiten Bibliotheksnetzwerk SLSP (Swiss Library Service Plattform) an. Für die Nutzerinnen und Nutzer hat dies weitreichende Folgen, über die wir Sie hiermit gerne informieren.
				</td> 				
				</tr> 
				  <tr> 				
				<td align="left" style="font-size:18px;padding-bottom: 10px;">
<strong> 1.	Neue Suchoberfläche und neues Rechercheportal </strong>
                 </td> 				
				</tr> 
				 <tr> 				
			<td align="left" style="padding-left: 24px;">
Das Rechercheportal Alexandria (<a href="https://www.alexandria.ch">www.alexandria.ch</a>) bietet ab dem 11. April 2022 neben dem Medienbestand des Verbunds über die Suchoberfläche swisscovery auch einen Zugriff auf den Grossteil des wissenschaftlichen Medienbestands der Schweiz (über 475 Bibliotheken).
                  </td> 				
				</tr> 
				<tr> 				
				<td align="left" style="font-size:18px;padding-bottom: 10px;">
<strong> 2.	Selbständige Neuregistration für alle Nutzerinnen und Nutzer</strong>
                               </td> 				
				</tr> 
				 <tr> 				
				<td align="left" style="padding-left: 24px;">
Um ab dem 11. April 2022 weiterhin über das Rechercheportal Alexandria Medien bestellen und ausleihen zu können, ist eine Neuregistrierung bei SLSP zwingend erforderlich. Ein SWITCH edu-ID Konto wiederum ist die Voraussetzung, um sich bei SLSP registrieren zu können. 
                                          </td> 				
				</tr> 
				<tr> 	
               <td style="color:red;padding-left: 24px;"> <strong>
Aus Datenschutzgründen muss die Registration selbst vorgenommen werden. Bestehende Benutzerkonten werden gelöscht und nicht übernommen.
                             </strong>
                              </td> 				
				</tr> 
				 <tr> 				
				<td align="left" style="padding-left: 24px;">
         Mitarbeitenden von Bundesverwaltung oder Armee wird empfohlen, sich mit der beruflichen Adresse zu registrieren. Melden Sie sich nach erfolgter 
        Registrierung per Mail bei bibliothek@gs-vbs.admin.ch, um der entsprechenden Kundengruppe zugeteilt zu werden. So können Sie nach der Einführung 
       des neuen Portals weiterhin von den Bedingungen für Bundesmitarbeitende profitieren.
							   </td> 				
				</tr>
                             <tr> 				
				<td align="left" style="padding-left: 24px;">
<a href="https://www.big.admin.ch/">Anleitung Registrierung SLSP mit vorhandener SWITCH edu-ID (PDF, de)</a> <br/>
<a href="https://www.big.admin.ch/">Anleitung Registrierung SLSP ohne SWITCH edu-ID (PDF, de)</a>
                               </td> 				
				</tr> 
					<tr> 				
				<td align="left" style="font-size:18px;padding-bottom: 10px;">
<strong> 3.	Einschränkungen im Ausleihbetrieb</strong>
                                        </td> 				
				</tr> 
                            <tr> 				
			<td align="left" style="padding-left: 24px;">
Damit die Umstellung auf das neue Rechercheportal reibungslos funktioniert, wird es einige
Einschränkungen im Ausleihbetrieb geben:
      </td> 				
				</tr>                                     

<tr> 				
				<td align="left" style="padding-left: 24px;">
<strong>Keine Fernleihbestellungen zwischen dem 1. März und 11. April 2022</strong><br/>
Der interbibliothekarische Leihverkehr wird vorübergehend eingestellt. Benutzerinnen und Benutzer werden gebeten, sämtliche über die Fernleihe bestellten Medien bis zum <strong>25. März 2022</strong> zurückzubringen.
                                </td> 				
				</tr> 
                             <tr> 				
				<td align="left" style="padding-left: 24px;">
<strong>Rückruf sämtlicher ausgeliehenen Medien bis 25. März 2022</strong><br/>
Alle Nutzerinnen und Nutzer sind angehalten, sämtliche Medien bis spätestens am <strong>25. März 2022</strong> zurückzugeben. Sie können ab dem 11. April 2022 nach Erstellung des Kontos erneut vor Ort oder via Post/Kurier ausgeliehen werden.
                                    </td> 				
				</tr> 
                                         <tr> 				
				<td align="left" style="padding-left: 24px;">
<strong>Keine Ausleihe, keine Rückgabe und keine Verlängerung zwischen 25. März und 11. April 2022:</strong><br/>
Der Ausleihbetrieb wird während der Migration vorübergehend eingestellt. Es können keine Ausleihen, Rückgaben oder Verlängerungen getätigt werden – weder im alten noch im neuen System.
                                   </td> 				
				</tr> 
                                          <tr> 				
				<td align="left" style="padding-left: 24px;"> 
Am 11. April 2022 geht das neue Rechercheportal unter <a href="https://www.alexandria.ch">www.alexandria.ch</a> online: Ausleihen sind nach erfolgter Registrierung (siehe Punkt 2) wieder möglich.
                                      </td> 				
				</tr> 
                        
                                                  <tr> 				
			<td align="left" style="padding-left: 24px;">
<strong>Löschung Reservationen und Favoriten</strong><br/>
Bestehende Reservationen auf ausgeliehene Medien werden gelöscht. Am besten notieren Sie sich die reservierten Medien, um sie nach dem 11. April 2022 erneut reservieren zu können.
                                           </td> 				
				</tr> 
				<tr> 				
				<td align="left" style="font-size:18px;padding-bottom: 10px;">
<strong> 4.	Neue Gebührenordnung</strong> <br/>
                                             </td> 				
				</tr>
<tr> 				
				<td align="left" style="padding-left: 24px;"> 
Mit dem Übergang zu SLSP führt die BiG am 11. April 2022 eine <a href="https://www.big.admin.ch/">Gebührenordnung</a> ein, die für Privatpersonen mit neuen Gebühren (Digitalisierungsaufträge/Mahnungen) verbunden ist.
              </td> 				
				</tr>
                                                     <tr> 				
				<td align="left" style="padding-left: 24px;">
Bundesmitarbeitende können nach erfolgter Registrierung weiterhin kostenlos von den Dienstleistungen der BiG profitieren, sofern sie nach dem 11. April 2022 der entsprechenden Kundengruppe zugeteilt wurden. Melden Sie sich hierzu per Mail bei: <a href="mailto:bibliothek@gs-vbs.admin.ch">bibliothek@gs-vbs.admin.ch</a> (siehe Punkt 2).  
                                                  </td> 				
				</tr>
                        <tr> 				
				<td align="left" style="font-size:18px;padding-bottom: 10px;">
<strong> 5. Aktuelle Informationen auf der Website der BiG</strong><br/>
                       </td> 				
				</tr>
 <tr> 				
			<td align="left" style="padding-left: 24px;"> 
Laufend aktuelle Informationen zum Übergang des Bibliotheksverbunds Alexandria zu SLSP finden Sie auf der <a href="https://www.big.admin.ch/">Website der BiG</a>.<br/>
Kontaktieren Sie uns, wir unterstützen Sie gerne und beantworten Ihre Fragen. <br/>
Freundliche Grüsse
                             </td> 				
				</tr>
                            <tr> 				
			<td align="left" style="padding-left: 24px;"> 
Bibliothek am Guisanplatz<br/>
Papiermühlestrasse 21a<br/>
CH-3003 Bern<br/>
Tel. +41 58 464 50 99<br/>
Mail: <a href="mailto:bibliothek@gs-vbs.admin.ch">bibliothek@gs-vbs.admin.ch</a>
                              </td> 				
				</tr>
				</table>
			</xsl:otherwise>
		</xsl:choose>
	</xsl:template>



						
						
						<br />
				<!--		<table role='presentation' >

							<tr>
								<td>@@Sincerely@@</td>
							</tr>
							<tr>
								<td>
									<xsl:value-of select="notification_data/organization_unit/name" />
								</td>
							</tr>
							<xsl:if test="notification_data/organization_unit/address/line1 !=''">
								<tr>
									<td>
										<xsl:value-of select="notification_data/organization_unit/address/line1" />
									</td>
								</tr>
							</xsl:if>
							<xsl:if test="notification_data/organization_unit/address/line2 !=''">
								<tr>
									<td>
										<xsl:value-of select="notification_data/organization_unit/address/line2" />
									</td>
								</tr>
							</xsl:if>
							<xsl:if test="notification_data/organization_unit/address/line3 !=''">
								<tr>
									<td>
										<xsl:value-of select="notification_data/organization_unit/address/line3" />
									</td>
								</tr>
							</xsl:if>
							<xsl:if test="notification_data/organization_unit/address/line4 !=''">
								<tr>
									<td>
										<xsl:value-of select="notification_data/organization_unit/address/line4" />
									</td>
								</tr>
							</xsl:if>
							<xsl:if test="notification_data/organization_unit/address/line5 !=''">
								<tr>
									<td>
										<xsl:value-of select="notification_data/organization_unit/address/line5" />
									</td>
								</tr>
							</xsl:if>
							<xsl:if test="notification_data/organization_unit/address/city !=''">
								<tr>
									<td>
										<xsl:value-of select="notification_data/organization_unit/address/city" />
									</td>
								</tr>
							</xsl:if>
							<xsl:if test="notification_data/organization_unit/address/country !=''">
								<tr>
									<td>
										<xsl:value-of select="notification_data/organization_unit/address/country" />
									</td>
								</tr>

							</xsl:if>

						</table>-->
					</div>
				</div>
				<!--<xsl:call-template name="lastFooter" /> -->
				<!-- footer.xsl -->
			</body>
		</html>
	</xsl:template>
</xsl:stylesheet>
