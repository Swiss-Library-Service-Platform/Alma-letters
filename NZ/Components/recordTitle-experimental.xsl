<?xml version="1.0" encoding="utf-8"?>
<!-- SLSP WG: Letters version 08/2021
10/2021	added template userAccount; removed labels for author and imprint
01/2022	SLSP-multilingual option for IZ with disabled languages
05/2022	added templates for extraction of volume, pages and request note in Resource Request Slip Letter
-->
<xsl:stylesheet version="1.0"
xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
	<!-- Source code from https://github.com/uio-library/alma-letters-ubo -->
	<!--
	Template to make it easier to insert multilingual text.
	*** Important ***: If the IZ has disabled a language in Alma UI, the appropriate param and <when> row need to be commented here as well (see SUPPORT-14329)
	Depends on: (none)
	When calling the template, the fr param is using CDATA to avoid error when single quote is in the text, i.e. n'ont
	USAGE:
		<xsl:call-template name="SLSP-multilingual">
			<xsl:with-param name="en" select="'Testing multilingual text.'"/>
			<xsl:with-param name="fr">
				<![CDATA[Test de texte multilingue.]]>
			</xsl:with-param>
			<xsl:with-param name="it" select="'Test di testi multilingue.'"/>
			<xsl:with-param name="de" select="'Testen von mehrsprachigem Text.'"/>
		</xsl:call-template>
-->
	<xsl:template name="SLSP-multilingual">
		<xsl:param name="en" />
		<xsl:param name="fr" />
		<xsl:param name="de" />
		<xsl:param name="it" />
		<xsl:choose>
			<xsl:when test="/notification_data/receivers/receiver/preferred_language = 'fr'">
				<xsl:value-of select="$fr"/>
			</xsl:when>
			<xsl:when test="/notification_data/receivers/receiver/preferred_language = 'en'">
				<xsl:value-of select="$en"/>
			</xsl:when>
			<xsl:when test="/notification_data/receivers/receiver/preferred_language = 'it'">
				<xsl:value-of select="$it"/>
			</xsl:when>
			<xsl:when test="/notification_data/receivers/receiver/preferred_language = 'de'">
				<xsl:value-of select="$de"/>
			</xsl:when>
			<xsl:otherwise>
				<xsl:value-of select="$en"/>
			</xsl:otherwise>
		</xsl:choose>
	</xsl:template>
	<!-- template to show link to user account
	for link to swisscovery uses system variable @@email_my_account@@ in Configuration -> General -> Other Settings
	one link per IZ is possible, therefore the default view is used.
	The lang parameter for URL is used from the user preferred language
	Depends on:
		recordTitle - SLSP-multilingual
	USAGE: <xsl:call-template name="SLSP-userAccount"/>
-->
	<xsl:template name="SLSP-userAccount">
		<xsl:call-template name="SLSP-multilingual">
			<xsl:with-param name="en" select="'To check your current loans and fees that have not yet been invoiced please login at swisscovery: '"/>
			<!-- Adaptation to include single quote in "n'ont" in the text -->
			<xsl:with-param name="fr">
				<![CDATA[Pour consulter vos prêts en cours et les frais qui n'ont pas encore été facturés, veuillez vous connecter à swisscovery: ]]>
			</xsl:with-param>
			<xsl:with-param name="it" select="'Per controllare i suoi prestiti attuali e i costi non ancora fatturati, effettui il login su swisscovery: '"/>
			<xsl:with-param name="de" select="'Um Ihre aktuellen Ausleihen und noch nicht in Rechnung gestellten Gebühren zu überprüfen, loggen Sie sich bitte bei swisscovery ein: '"/>
		</xsl:call-template>
		<a>
			<xsl:attribute name="href">@@email_my_account@@&#38;lang=
				<xsl:value-of select="/notification_data/receivers/receiver/preferred_language"/>
			</xsl:attribute>
			<xsl:attribute name="target">
			_blank
		</xsl:attribute>
			<xsl:call-template name="SLSP-multilingual">
				<xsl:with-param name="en" select="'My account'"/>
				<xsl:with-param name="fr" select="'Mon compte'"/>
				<xsl:with-param name="it" select="'Il mio conto'"/>
				<xsl:with-param name="de" select="'Mein Konto'"/>
			</xsl:call-template>
		</a>
	</xsl:template>
	<!-- Template to extract request note from Rapido request
	Usage:
		<xsl:variable name="requestNote">
			<xsl:call-template name="SLSP-Rapido-request-note" />
		</xsl:variable>
		<xsl:if test="$requestNote != ''">
		...
		</xsl:if>
		
-->
	<xsl:template name="SLSP-Rapido-request-note">
		<xsl:choose>
			<xsl:when test="/notification_data/incoming_request/note != ''">
				<xsl:value-of select="/notification_data/incoming_request/note"/>
			</xsl:when>
			<xsl:when test="/notification_data/request/note != ''">
				<xsl:value-of select="/notification_data/request/note"/>
			</xsl:when>
		</xsl:choose>
	</xsl:template>
	<!-- Template to extract volume from the encoded XML metadata provided in letter XML
	Usage: 
		<xsl:variable name="requestVolume">
			<xsl:call-template name="SLSP-Rapido-extract-volume" />
		</xsl:variable>
		<xsl:if test="$requestVolume != ''">
		...
		</xsl:if>
-->
	<xsl:template name="SLSP-Rapido-extract-volume">
		<!-- Loading of the righthand part of metadata field based on XML layout -->
		<xsl:variable name="user-volume-temp">
			<xsl:choose>
				<xsl:when test="/notification_data/incoming_request/request_metadata != ''">
					<xsl:value-of select="substring-after(/notification_data/incoming_request/request_metadata, 'dc:volume&gt;')"/>
				</xsl:when>
				<xsl:when test="/notification_data/resource_sharing_request/request_metadata != ''">
					<xsl:value-of select="substring-after(/notification_data/resource_sharing_request/request_metadata, 'dc:volume&gt;')"/>
				</xsl:when>
			</xsl:choose>
		</xsl:variable>
		<xsl:value-of select="substring-before($user-volume-temp, '&lt;/dc:volume')"/>
	</xsl:template>
	<!-- Template to extract pages from the encoded XML metadata provided in letter XML
	Usage: 
		<xsl:variable name="requestPages">
			<xsl:call-template name="SLSP-Rapido-extract-pages" />
		</xsl:variable>
		<xsl:if test="$requestPages != ''">
		...
		</xsl:if>
-->
	<xsl:template name="SLSP-Rapido-extract-pages">
		<!-- Loading of the righthand part of metadata field based on XML layout -->
		<xsl:variable name="user-pages-temp">
			<xsl:choose>
				<xsl:when test="/notification_data/incoming_request/request_metadata != ''">
					<xsl:value-of select="substring-after(/notification_data/incoming_request/request_metadata, 'dc:rlterms_pages&gt;')"/>
				</xsl:when>
				<xsl:when test="/notification_data/resource_sharing_request/request_metadata != ''">
					<xsl:value-of select="substring-after(/notification_data/resource_sharing_request/request_metadata, 'dc:rlterms_pages&gt;')"/>
				</xsl:when>
			</xsl:choose>
		</xsl:variable>
		<xsl:value-of select="substring-before($user-pages-temp, '&lt;/dc:rlterms_pages')"/>
	</xsl:template>
	<!-- Template to add contact us link using the system variable
	email_contact_us - system variable in Configuration -> General -> Other Settings -->
	<xsl:template name="SLSP-contactUs">
		<table align="left">
			<tr>
				<td align="left">
					<a>
						<xsl:attribute name="href">
                          @@email_contact_us@@
                        </xsl:attribute>
						<xsl:call-template name="SLSP-multilingual">
							<xsl:with-param name="en" select="'Contact the '"/>
							<xsl:with-param name="fr" select="'Mon compte'"/>
							<xsl:with-param name="it" select="'Il mio conto'"/>
							<xsl:with-param name="de" select="'Mein Konto'"/>
						</xsl:call-template>
					</a>
				</td>
			</tr>
		</table>
	</xsl:template>

	<!-- Template to add greeting to letters in case the label is missing in configuration -->
	<xsl:template name="SLSP-greeting">
		<xsl:call-template name="SLSP-multilingual">
			<xsl:with-param name="en" select="'Hello,'"/>
			<xsl:with-param name="fr" select="'Bonjour,'"/>
			<xsl:with-param name="it" select="'Buongiorno,'"/>
			<xsl:with-param name="de" select="'Guten Tag'"/>
		</xsl:call-template>
	</xsl:template>

	<xsl:template name="recordTitle">
		<div class="recordTitle">
			<span class="spacer_after_1em">
				<span class="recordTitle">
					<strong>
						<xsl:value-of select="notification_data/phys_item_display/title" disable-output-escaping="yes"/>
					</strong>
				</span>
			</span>
		</div>
		<xsl:if test="notification_data/phys_item_display/author !=''">
			<div class="">
				<span class="spacer_after_1em">
					<span class="recordAuthor">
						<xsl:value-of select="notification_data/phys_item_display/author"/>
					</span>
				</span>
			</div>
		</xsl:if>
		<xsl:if test="notification_data/phys_item_display/imprint !=''">
			<div class="">
				<span class="spacer_after_1em">
					<xsl:value-of select="notification_data/phys_item_display/publication_place"/>:&#160;
					<xsl:value-of select="notification_data/phys_item_display/publisher"/>,&#160;
					<xsl:value-of select="notification_data/phys_item_display/publication_date"/>
				</span>
			</div>
		</xsl:if>
		<xsl:if test="notification_data/phys_item_display/isbn !=''">
			<div class="">
				<span class="spacer_after_1em">
					<span class="recordIdentifier">ISBN:
						<xsl:value-of select="notification_data/phys_item_display/isbn"/>
					</span>
				</span>
			</div>
		</xsl:if>
		<xsl:if test="notification_data/phys_item_display/issn !=''">
			<div class="">
				<span class="spacer_after_1em">
					<span class="recordIdentifier">ISSN:
						<xsl:value-of select="notification_data/phys_item_display/issn"/>
					</span>
				</span>
			</div>
		</xsl:if>
		<xsl:if test="notification_data/phys_item_display/issue_level_description !='' and notification_data/phys_item_display/issue_level_description != 'Vol.' and notification_data/phys_item_display/issue_level_description != '_'">
			<div class="">
				<span class="spacer_after_1em">
					<span class="description">@@description@@
						<xsl:value-of select="notification_data/phys_item_display/issue_level_description"/>
					</span>
				</span>
			</div>
		</xsl:if>
	</xsl:template>
</xsl:stylesheet>