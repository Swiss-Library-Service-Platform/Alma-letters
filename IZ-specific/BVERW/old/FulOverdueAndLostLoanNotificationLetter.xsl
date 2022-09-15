<?xml version="1.0" encoding="utf-8"?>

<xsl:stylesheet version="1.0"
xmlns:xsl="http://www.w3.org/1999/XSL/Transform">

<xsl:include href="senderReceiver.xsl" />
<xsl:include href="mailReason.xsl" />
<xsl:include href="footer.xsl" />
<xsl:include href="style.xsl" />

<xsl:template name="head">
<table cellspacing="0" cellpadding="5" border="0">
	<xsl:attribute name="style">
		<xsl:call-template name="headerTableStyleCss" /> <!-- style.xsl -->
	</xsl:attribute>
	<tr>
		<xsl:for-each select="notification_data">
		<td>
		<xsl:if test="receivers/receiver/preferred_language='de' and notification_type='OverdueNotificationType1'">
			<h3>Überfällige Ausleihen - Erinnerung</h3>
		</xsl:if>
		<xsl:if test="receivers/receiver/preferred_language='de' and notification_type='OverdueNotificationType2'">
			<h3>Überfällige Ausleihen - 1. Mahnung</h3>
		</xsl:if>
		<xsl:if test="receivers/receiver/preferred_language='de' and notification_type='OverdueNotificationType3'">
			<h3>Überfällige Ausleihen - 2. Mahnung</h3>
		</xsl:if>
		<xsl:if test="receivers/receiver/preferred_language='de' and notification_type='OverdueNotificationType4'">
			<h3>Überfällige Ausleihen - 3. Mahnung</h3>
		</xsl:if>
		<xsl:if test="receivers/receiver/preferred_language='de' and notification_type='OverdueNotificationType5'">
			<h3>Überfällige Ausleihen - 4. Mahnung</h3>
		</xsl:if>
		<xsl:if test="receivers/receiver/preferred_language='fr' and notification_type='OverdueNotificationType1'">
			<h3>Exemplaires en retard - réclamation</h3>
		</xsl:if>
		<xsl:if test="receivers/receiver/preferred_language='fr' and notification_type='OverdueNotificationType2'">
			<h3>Exemplaires en retard - 1er rappel</h3>
		</xsl:if>
		<xsl:if test="receivers/receiver/preferred_language='fr' and notification_type='OverdueNotificationType3'">
			<h3>Exemplaires en retard - 2ème rappel</h3>
		</xsl:if>
		<xsl:if test="receivers/receiver/preferred_language='fr' and notification_type='OverdueNotificationType4'">
			<h3>Exemplaires en retard - 3ème rappel</h3>
		</xsl:if>
		<xsl:if test="receivers/receiver/preferred_language='fr' and notification_type='OverdueNotificationType5'">
			<h3>Exemplaires en retard - 4ème rappel</h3>
		</xsl:if>
		<xsl:if test="receivers/receiver/preferred_language='eng' and notification_type='OverdueNotificationType1'">
			<h3>Overdue items - return request</h3>
		</xsl:if>
		<xsl:if test="receivers/receiver/preferred_language='eng' and notification_type='OverdueNotificationType2'">
			<h3>Overdue items - 1st reminder</h3>
		</xsl:if>
		<xsl:if test="receivers/receiver/preferred_language='eng' and notification_type='OverdueNotificationType3'">
			<h3>Overdue items - 2nd reminder</h3>
		</xsl:if>
		<xsl:if test="receivers/receiver/preferred_language='eng' and notification_type='OverdueNotificationType4'">
			<h3>Overdue items - 3rd reminder</h3>
		</xsl:if>
		<xsl:if test="receivers/receiver/preferred_language='eng' and notification_type='OverdueNotificationType5'">
			<h3>Overdue items - 4th reminder</h3>
		</xsl:if>
		<xsl:if test="receivers/receiver/preferred_language='it' and notification_type='OverdueNotificationType1'">
			<h3>Copie in ritardo - primo sollecito</h3>
		</xsl:if>
		<xsl:if test="receivers/receiver/preferred_language='it' and notification_type='OverdueNotificationType2'">
			<h3>Copie in ritardo - primo sollecito</h3>
		</xsl:if>
		<xsl:if test="receivers/receiver/preferred_language='it' and notification_type='OverdueNotificationType3'">
			<h3>Copie in ritardo - secondo sollecito</h3>
		</xsl:if>
		<xsl:if test="receivers/receiver/preferred_language='it' and notification_type='OverdueNotificationType4'">
			<h3>Copie in ritardo - terzo sollecito</h3>
		</xsl:if>
		<xsl:if test="receivers/receiver/preferred_language='it' and notification_type='OverdueNotificationType5'">
			<h3>Copie in ritardo - quarto  sollecito</h3>
		</xsl:if>
		<xsl:if test="receivers/receiver/preferred_language='' and notification_type='OverdueNotificationType1'">
			<h3>Overdue items - return request</h3>
		</xsl:if>
		<xsl:if test="receivers/receiver/preferred_language='' and notification_type='OverdueNotificationType2'">
			<h3>Overdue items - 1st reminder</h3>
		</xsl:if>
		<xsl:if test="receivers/receiver/preferred_language='' and notification_type='OverdueNotificationType3'">
			<h3>Overdue items - 2nd reminder</h3>
		</xsl:if>
		<xsl:if test="receivers/receiver/preferred_language='' and notification_type='OverdueNotificationType4'">
			<h3>Overdue items - 3rd reminder</h3>
		</xsl:if>
		<xsl:if test="receivers/receiver/preferred_language='' and notification_type='OverdueNotificationType5'">
			<h3>Overdue items - 4th reminder</h3>
		</xsl:if>
		</td>
		<td align="right">
			<xsl:value-of select="general_data/current_date"/>
		</td>
		</xsl:for-each>
	</tr>

</table>
</xsl:template>

<xsl:template match="/">
	<html>
		<head>
			<xsl:call-template name="generalStyle" /> <!-- style.xsl -->
		</head>

		<body>
			<xsl:attribute name="style">
				<xsl:call-template name="bodyStyleCss" /> <!-- style.xsl -->
			</xsl:attribute>
			<xsl:call-template name="head" /> <!-- header.xsl -->
			<xsl:call-template name="senderReceiver" /> <!-- SenderReceiver.xsl -->
			<br />
			<br />
		<xsl:call-template name="toWhomIsConcerned" /> <!-- mailReason.xsl --> 


        <div class="messageArea">
          <div class="messageBody">

			<table cellspacing="0" cellpadding="5" border="0">
			<tr>
			<td>
				<h>@@inform_you_item_below@@</h>
				<xsl:for-each select="notification_data">
					<xsl:if test="notification_type='OverdueNotificationType1'">
						<h><b>@@decalred_as_lost_type1@@</b>@@additional_info_2@@</h>
					</xsl:if>
					<xsl:if test="notification_type='OverdueNotificationType2' and display_list/overdue_and_lost_loan_notification_display/physical_item_display_for_printing/library_code!='RES_SHARE' and display_list/overdue_and_lost_loan_notification_display/physical_item_display_for_printing/library_code!='SECO'">
						<h><b>@@decalred_as_lost_type2@@</b>@@additional_info_2@@</h>
					</xsl:if>
					<xsl:if test="notification_type='OverdueNotificationType3' and display_list/overdue_and_lost_loan_notification_display/physical_item_display_for_printing/library_code!='RES_SHARE' and display_list/overdue_and_lost_loan_notification_display/physical_item_display_for_printing/library_code!='SECO'">
						<h><b>@@decalred_as_lost_type3@@</b>@@additional_info_2@@</h>
					</xsl:if>
					<xsl:if test="notification_type='OverdueNotificationType4' and display_list/overdue_and_lost_loan_notification_display/physical_item_display_for_printing/library_code!='RES_SHARE' and display_list/overdue_and_lost_loan_notification_display/physical_item_display_for_printing/library_code!='SECO'">
						<h><b>@@decalred_as_lost_type4@@</b>@@additional_info_2@@</h>
					</xsl:if>
					<xsl:if test="notification_type='OverdueNotificationType5' and display_list/overdue_and_lost_loan_notification_display/physical_item_display_for_printing/library_code!='RES_SHARE' and display_list/overdue_and_lost_loan_notification_display/physical_item_display_for_printing/library_code!='SECO'">
						<h><b>@@decalred_as_lost_type5@@</b>@@additional_info_2@@</h>
					</xsl:if>
					<xsl:if test="notification_type='OverdueNotificationType2' and display_list/overdue_and_lost_loan_notification_display/physical_item_display_for_printing/library_code='RES_SHARE'">
						<h><b>@@additional_info_2_type1@@</b>@@additional_info_2@@</h>
					</xsl:if>
					<xsl:if test="notification_type='OverdueNotificationType3' and display_list/overdue_and_lost_loan_notification_display/physical_item_display_for_printing/library_code='RES_SHARE'">
						<h><b>@@additional_info_2_type2@@</b>@@additional_info_2@@</h>
					</xsl:if>
					<xsl:if test="notification_type='OverdueNotificationType4' and display_list/overdue_and_lost_loan_notification_display/physical_item_display_for_printing/library_code='RES_SHARE'">
						<h><b>@@additional_info_2_type3@@</b>@@additional_info_2@@</h>
					</xsl:if>
					<xsl:if test="notification_type='OverdueNotificationType5' and display_list/overdue_and_lost_loan_notification_display/physical_item_display_for_printing/library_code='RES_SHARE'">
						<h><b>@@additional_info_2_type4@@</b>@@additional_info_2@@</h>
					</xsl:if>
					<xsl:if test="notification_type='OverdueNotificationType2' and display_list/overdue_and_lost_loan_notification_display/physical_item_display_for_printing/library_code='SECO' and (display_list/overdue_and_lost_loan_notification_display/item_loan/material_type='ISSUE' or display_list/overdue_and_lost_loan_notification_display/item_loan/material_type='ISSBD' or display_list/overdue_and_lost_loan_notification_display/item_loan/material_type='NEWSPAPER')">
						<h><b>@@decalred_as_lost_type2@@</b>@@additional_info_2@@</h>
					</xsl:if>
					<xsl:if test="notification_type='OverdueNotificationType3' and display_list/overdue_and_lost_loan_notification_display/physical_item_display_for_printing/library_code='SECO' and (display_list/overdue_and_lost_loan_notification_display/item_loan/material_type='ISSUE' or display_list/overdue_and_lost_loan_notification_display/item_loan/material_type='ISSBD' or display_list/overdue_and_lost_loan_notification_display/item_loan/material_type='NEWSPAPER')">
						<h><b>@@decalred_as_lost_type3@@</b>@@additional_info_2@@</h>
					</xsl:if>
					<xsl:if test="notification_type='OverdueNotificationType2' and display_list/overdue_and_lost_loan_notification_display/physical_item_display_for_printing/library_code='SECO' and (display_list/overdue_and_lost_loan_notification_display/item_loan/material_type!='ISSUE' and display_list/overdue_and_lost_loan_notification_display/item_loan/material_type!='ISSBD' and display_list/overdue_and_lost_loan_notification_display/item_loan/material_type!='NEWSPAPER')">
						<h><b>@@decalred_as_lost_type3@@</b>@@additional_info_2@@</h>
					</xsl:if>
					<xsl:if test="notification_type='OverdueNotificationType3' and display_list/overdue_and_lost_loan_notification_display/physical_item_display_for_printing/library_code='SECO' and (display_list/overdue_and_lost_loan_notification_display/item_loan/material_type!='ISSUE' and display_list/overdue_and_lost_loan_notification_display/item_loan/material_type!='ISSBD' and display_list/overdue_and_lost_loan_notification_display/item_loan/material_type!='NEWSPAPER')">
						<h><b>@@additional_info_2_type5@@</b>@@additional_info_2@@</h>
					</xsl:if>
				</xsl:for-each>
			</td>
			</tr>
			</table>				

			<table cellpadding="5" class="listing">
				<xsl:attribute name="style">
					<xsl:call-template name="mainTableStyleCss" /> <!-- style.xsl -->
				</xsl:attribute>

				<table cellpadding="5" class="listing">
				<xsl:attribute name="style">
					<xsl:call-template name="mainTableStyleCss" /> <!-- style.xsl -->
				</xsl:attribute>
					<tr>
						<th>@@lost_item@@</th>
						<th>@@description@@</th>
						<th>@@library@@</th>
						<th>@@loan_date@@</th>
						<th>@@due_date@@</th>
						<th>@@call_number@@</th>
						<th>@@additional_info_1_type1@@</th>
					</tr>
					<xsl:for-each select="notification_data/display_list/overdue_and_lost_loan_notification_display">
					<tr>
						<td><xsl:value-of select="item_loan/title"/></td>
						<td><xsl:value-of select="item_loan/description"/></td>
						<td><xsl:value-of select="physical_item_display_for_printing/library_name"/></td>
						<td><xsl:value-of select="item_loan/loan_date"/></td>
						<td><xsl:value-of select="item_loan/due_date"/></td>
						<td><xsl:value-of select="physical_item_display_for_printing/call_number"/></td>
						<xsl:choose>
							<xsl:when test="item_loan/process_status='RENEW REQUESTED'">
								<td>@@additional_info_1_type2@@</td>
							</xsl:when>
							<xsl:when test="item_loan/process_status='RECALL'">
								<td>@@additional_info_1_type2@@</td>
							</xsl:when>
							<xsl:when test="item_loan/process_status='CLAIM RETURNED'">
								<td>@@additional_info_1_type2@@</td>
							</xsl:when>
							<xsl:otherwise>
								<td>&#160;</td>
							</xsl:otherwise>
						</xsl:choose>
					</tr>
					</xsl:for-each>

				</table>
				<br />		
				
				<xsl:for-each select="notification_data">
				<xsl:if test="(display_list/overdue_and_lost_loan_notification_display/physical_item_display_for_printing/library_code='PSCH' or display_list/overdue_and_lost_loan_notification_display/physical_item_display_for_printing/library_code='Test') and notification_type='OverdueNotificationType2'">
					<h><b>@@charged_with_fines_fees_type1@@</b></h>
				</xsl:if>
				<xsl:if test="(display_list/overdue_and_lost_loan_notification_display/physical_item_display_for_printing/library_code='PSCH' or display_list/overdue_and_lost_loan_notification_display/physical_item_display_for_printing/library_code='Test') and notification_type='OverdueNotificationType3'">
					<h><b>@@charged_with_fines_fees_type2@@</b></h>
				</xsl:if>
				<xsl:if test="(display_list/overdue_and_lost_loan_notification_display/physical_item_display_for_printing/library_code='PSCH' or display_list/overdue_and_lost_loan_notification_display/physical_item_display_for_printing/library_code='Test') and notification_type='OverdueNotificationType4'">
					<h><b>@@charged_with_fines_fees_type3@@</b></h>
				</xsl:if>
				<xsl:if test="display_list/overdue_and_lost_loan_notification_display/physical_item_display_for_printing/library_code!='PSCH' and display_list/overdue_and_lost_loan_notification_display/physical_item_display_for_printing/library_code!='Test'">
					<h>&#160;</h>
				</xsl:if>
				</xsl:for-each>  
			</table>
				<br />
			<table>
				<tr><td>@@sincerely@@</td></tr>
				<tr>
					<xsl:for-each select="notification_data">
						<xsl:if test="display_list/overdue_and_lost_loan_notification_display/physical_item_display_for_printing/library_code='DEZA' and (receivers/receiver/preferred_language='de' or receivers/receiver/preferred_language='')">
							<td>Abteilung Wissen-Lernen-Kultur</td>
						</xsl:if>
						<xsl:if test="display_list/overdue_and_lost_loan_notification_display/physical_item_display_for_printing/library_code='DEZA' and receivers/receiver/preferred_language='fr'">
							<td>Division Savoir-Apprentissage-Culture</td>
						</xsl:if>
						<xsl:if test="display_list/overdue_and_lost_loan_notification_display/physical_item_display_for_printing/library_code='DEZA' and receivers/receiver/preferred_language='en'">
							<td>Knowledge-Learning-Culture Division</td>
						</xsl:if>
						<xsl:if test="display_list/overdue_and_lost_loan_notification_display/physical_item_display_for_printing/library_code='DEZA' and receivers/receiver/preferred_language='it'">
							<td>Divisione Sapere-Apprendimento-Cultura</td>
						</xsl:if>
						<xsl:if test="display_list/overdue_and_lost_loan_notification_display/physical_item_display_for_printing/library_code='PSCH' and (receivers/receiver/preferred_language='de' or receivers/receiver/preferred_language='')">
							<td>Pro Senectute Bibliothek</td>
						</xsl:if>
						<xsl:if test="display_list/overdue_and_lost_loan_notification_display/physical_item_display_for_printing/library_code='PSCH' and receivers/receiver/preferred_language='fr'">
							<td>Bibliothèque de Pro Senectute</td>
						</xsl:if>
						<xsl:if test="display_list/overdue_and_lost_loan_notification_display/physical_item_display_for_printing/library_code='PSCH' and receivers/receiver/preferred_language='en'">
							<td>Pro Senectute Library</td>
						</xsl:if>
						<xsl:if test="display_list/overdue_and_lost_loan_notification_display/physical_item_display_for_printing/library_code='PSCH' and receivers/receiver/preferred_language='it'">
							<td>Biblioteca di Pro Senectute</td>
						</xsl:if>
						<xsl:if test="display_list/overdue_and_lost_loan_notification_display/physical_item_display_for_printing/library_code='BIG' and (receivers/receiver/preferred_language='de' or receivers/receiver/preferred_language='')">
							<td>Bibliothek am Guisanplatz BiG</td>
						</xsl:if>
						<xsl:if test="display_list/overdue_and_lost_loan_notification_display/physical_item_display_for_printing/library_code='BIG' and receivers/receiver/preferred_language='fr'">
							<td>Bibliothèque Am Guisanplatz BiG</td>
						</xsl:if>
						<xsl:if test="display_list/overdue_and_lost_loan_notification_display/physical_item_display_for_printing/library_code='BIG' and receivers/receiver/preferred_language='en'">
							<td>Library Am Guisanplatz BiG</td>
						</xsl:if>
						<xsl:if test="display_list/overdue_and_lost_loan_notification_display/physical_item_display_for_printing/library_code='BIG' and receivers/receiver/preferred_language='it'">
							<td>Biblioteca Am Guisanplatz BiG</td>
						</xsl:if>
						<xsl:if test="display_list/overdue_and_lost_loan_notification_display/physical_item_display_for_printing/library_code='SECO' and (receivers/receiver/preferred_language='de' or receivers/receiver/preferred_language='')">
							<td>SECO Dokumentation</td>
						</xsl:if>
						<xsl:if test="display_list/overdue_and_lost_loan_notification_display/physical_item_display_for_printing/library_code='SECO' and receivers/receiver/preferred_language='fr'">
							<td>Documentation du SECO</td>
						</xsl:if>
						<xsl:if test="display_list/overdue_and_lost_loan_notification_display/physical_item_display_for_printing/library_code='SECO' and receivers/receiver/preferred_language='en'">
							<td>SECO Documentation</td>
						</xsl:if>
						<xsl:if test="display_list/overdue_and_lost_loan_notification_display/physical_item_display_for_printing/library_code='SECO' and receivers/receiver/preferred_language='it'">
							<td>Documentazione SECO</td>
						</xsl:if>
						<xsl:if test="display_list/overdue_and_lost_loan_notification_display/physical_item_display_for_printing/library_code='BFS' and (receivers/receiver/preferred_language='de' or receivers/receiver/preferred_language='')">
							<td>Bibliothek BFS</td>
						</xsl:if>
						<xsl:if test="display_list/overdue_and_lost_loan_notification_display/physical_item_display_for_printing/library_code='BFS' and receivers/receiver/preferred_language='fr'">
							<td>Bibliothèque de l'OFS</td>
						</xsl:if>
						<xsl:if test="display_list/overdue_and_lost_loan_notification_display/physical_item_display_for_printing/library_code='BFS' and receivers/receiver/preferred_language='en'">
							<td>Library FSO</td>
						</xsl:if>
						<xsl:if test="display_list/overdue_and_lost_loan_notification_display/physical_item_display_for_printing/library_code='BFS' and receivers/receiver/preferred_language='it'">
							<td>Biblioteca UST</td>
						</xsl:if>
						<xsl:if test="display_list/overdue_and_lost_loan_notification_display/physical_item_display_for_printing/library_code='RUAG' and (receivers/receiver/preferred_language='de' or receivers/receiver/preferred_language='')">
							<td>Bibliothek RUAG-A</td>
						</xsl:if>
						<xsl:if test="display_list/overdue_and_lost_loan_notification_display/physical_item_display_for_printing/library_code='RUAG' and receivers/receiver/preferred_language='fr'">
							<td>Bibliothèque de RUAG-A</td>
						</xsl:if>
						<xsl:if test="display_list/overdue_and_lost_loan_notification_display/physical_item_display_for_printing/library_code='RUAG' and receivers/receiver/preferred_language='en'">
							<td>Library RUAG-A</td>
						</xsl:if>
						<xsl:if test="display_list/overdue_and_lost_loan_notification_display/physical_item_display_for_printing/library_code='RUAG' and receivers/receiver/preferred_language='it'">
							<td>Biblioteca RUAG-A</td>
						</xsl:if>
						<xsl:if test="display_list/overdue_and_lost_loan_notification_display/physical_item_display_for_printing/library_code='MILAK' and (receivers/receiver/preferred_language='de' or receivers/receiver/preferred_language='')">
							<td>Bibliothek MILAK</td>
						</xsl:if>
						<xsl:if test="display_list/overdue_and_lost_loan_notification_display/physical_item_display_for_printing/library_code='MILAK' and receivers/receiver/preferred_language='fr'">
							<td>Bibliothèque de l'ACAMIL</td>
						</xsl:if>
						<xsl:if test="display_list/overdue_and_lost_loan_notification_display/physical_item_display_for_printing/library_code='MILAK' and receivers/receiver/preferred_language='en'">
							<td>Library MILAC</td>
						</xsl:if>
						<xsl:if test="display_list/overdue_and_lost_loan_notification_display/physical_item_display_for_printing/library_code='MILAK' and receivers/receiver/preferred_language='it'">
							<td>Biblioteca ACMIL</td>
						</xsl:if>
						<xsl:if test="display_list/overdue_and_lost_loan_notification_display/physical_item_display_for_printing/library_code='RES_SHARE' and (receivers/receiver/preferred_language='de' or receivers/receiver/preferred_language='')">
							<td>Fernleihe der Bibliothek am Guisanplatz BiG</td>
						</xsl:if>
						<xsl:if test="display_list/overdue_and_lost_loan_notification_display/physical_item_display_for_printing/library_code='RES_SHARE' and receivers/receiver/preferred_language='fr'">
							<td>Service de prêt entre bibliothèques de la Bibliothèque Am Guisanplatz BiG</td>
						</xsl:if>
						<xsl:if test="display_list/overdue_and_lost_loan_notification_display/physical_item_display_for_printing/library_code='RES_SHARE' and receivers/receiver/preferred_language='en'">
							<td>Interlibrary Loan Service of the Library Am Guisanplatz BiG</td>
						</xsl:if>
						<xsl:if test="display_list/overdue_and_lost_loan_notification_display/physical_item_display_for_printing/library_code='RES_SHARE' and receivers/receiver/preferred_language='it'">
							<td>Prestito interbibliotecario della Biblioteca Am Guisanplatz BiG</td>
						</xsl:if>
						<xsl:if test="display_list/overdue_and_lost_loan_notification_display/physical_item_display_for_printing/library_code!='DEZA' and display_list/overdue_and_lost_loan_notification_display/physical_item_display_for_printing/library_code!='MILAK' and display_list/overdue_and_lost_loan_notification_display/physical_item_display_for_printing/library_code!='RUAG' and display_list/overdue_and_lost_loan_notification_display/physical_item_display_for_printing/library_code!='BFS' and display_list/overdue_and_lost_loan_notification_display/physical_item_display_for_printing/library_code!='SECO' and display_list/overdue_and_lost_loan_notification_display/physical_item_display_for_printing/library_code!='PSCH' and display_list/overdue_and_lost_loan_notification_display/physical_item_display_for_printing/library_code!='BIG' and display_list/overdue_and_lost_loan_notification_display/physical_item_display_for_printing/library_code!='RES_SHARE'">
							<td>Ihre Bibliothek / Votre bibliothèque / Your library <xsl:value-of select="display_list/overdue_and_lost_loan_notification_display/physical_item_display_for_printing/library_name"/></td>
						</xsl:if>	
					</xsl:for-each>						
				</tr>
			</table>
          </div>
        </div>

        <!-- footer.xsl -->
        <xsl:call-template name="lastFooter" />
      </body>
    </html>
  </xsl:template>
</xsl:stylesheet>