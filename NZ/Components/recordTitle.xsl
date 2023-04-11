<?xml version="1.0" encoding="utf-8"?>
<!-- SLSP WG: Letters version 08/2021
10/2021	added template userAccount; removed labels for author and imprint
01/2022	SLSP-multilingual option for IZ with disabled languages
05/2022	added templates for extraction of volume, pages and request note in Resource Request Slip Letter
06/2022 added personal delivery field extraction
09/2022 Added templates SLSP-greeting and SLSP-sincerely
10/2022 Added templates SLSP-greeting-ILL; updated SLSP-multilingual
11/2022	Added template SLSP-Rapido-destination
02/2023 Added template for IZ message
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
			<xsl:when test="/notification_data/receivers/receiver/preferred_language != ''">
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
			</xsl:when>
			<!-- Added for letters where the recipient's preferred language is not specified.
			Grabs the language of the letter. -->
			<xsl:otherwise>
				<xsl:choose>
					<xsl:when test="notification_data/languages/string[1] = 'fr'">
						<xsl:value-of select="$fr"/>
					</xsl:when>
					<xsl:when test="notification_data/languages/string[1] = 'en'">
						<xsl:value-of select="$en"/>
					</xsl:when>
					<xsl:when test="notification_data/languages/string[1] = 'it'">
						<xsl:value-of select="$it"/>
					</xsl:when>
					<xsl:when test="notification_data/languages/string[1] = 'de'">
						<xsl:value-of select="$de"/>
					</xsl:when>
					<xsl:otherwise>
						<xsl:value-of select="$en"/>
					</xsl:otherwise>
				</xsl:choose>
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
			<xsl:with-param name="de" select="'Um Ihre aktuellen Ausleihen und noch nicht in Rechnung gestellte Gebühren zu überprüfen, loggen Sie sich bitte bei swisscovery ein: '"/>
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

	<!-- Template for Resource Sharing Request Slip to extract request note from Rapido request
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

	<!-- Template for Resource Sharing Request Slip to extract volume from the encoded XML metadata provided in letter XML
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

	<!-- Template for Resource Sharing Request Slip to extract pages from the encoded XML metadata provided in letter XML
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

	<!-- Template for Resource Sharing Request Slip to print the home / office delivery information
        Usage:
            <xsl:variable name="personalDelivery">
                <xsl:call-template name="SLSP-Rapido-persDel" />
            </xsl:variable>
            ...
            <xsl:value-of select="notification_data/request_type"/>
            <xsl:if test="$personalDelivery != ''">
                - <xsl:value-of select="$personalDelivery"/>
            </xsl:if>
            -->
	<xsl:template name="SLSP-Rapido-persDel">
		<xsl:if test="/notification_data/incoming_request/rapido_delivery_option != ''">
			<xsl:value-of select="/notification_data/incoming_request/rapido_delivery_option"/>
		</xsl:if>
	</xsl:template>

	<!-- Template for Resource Sharing Request Slip to extract destination from Rapido request.
        Returns either Rapido partner name or request destination
	Usage:
		<xsl:variable name="destination">
			<xsl:call-template name="SLSP-Rapido-destination" />
		</xsl:variable>
		<xsl:value-of select="$destination"/>
    -->
    <xsl:template name="SLSP-Rapido-destination">
        <xsl:choose>
            <xsl:when test="/notification_data/incoming_request/partner_name != ''
			and /notification_data/incoming_request/rapido_request = 'true'">
                <xsl:value-of select="/notification_data/incoming_request/partner_name"/>
            </xsl:when>
            <xsl:otherwise>
                <xsl:value-of select="/notification_data/destination"/>
            </xsl:otherwise>
        </xsl:choose>
    </xsl:template>

	<!-- Template to add greeting to letters in case the label is missing in configuration
	USAGE: <xsl:call-template name="SLSP-greeting" /> -->
	<xsl:template name="SLSP-greeting">
		<xsl:call-template name="SLSP-multilingual">
			<xsl:with-param name="en" select="'Hello,'"/>
			<xsl:with-param name="fr" select="'Bonjour,'"/>
			<xsl:with-param name="it" select="'Buongiorno,'"/>
			<xsl:with-param name="de" select="'Guten Tag'"/>
		</xsl:call-template>
	</xsl:template>
	
	<!-- Template to add greeting to ILL letters in case the label is missing in configuration
	USAGE: <xsl:call-template name="SLSP-greeting-ILL" /> -->
	<xsl:template name="SLSP-greeting-ILL">
		<xsl:call-template name="SLSP-multilingual">
			<xsl:with-param name="en" select="'Dear Colleagues,'"/>
			<xsl:with-param name="fr" select="'Cher(e)s collègues,'"/>
			<xsl:with-param name="it" select="'Care colleghe e cari colleghi,'"/>
			<xsl:with-param name="de" select="'Liebe Kolleginen und Kollegen'"/>
		</xsl:call-template>
	</xsl:template>

	<!-- Template to add sincerely paragraph to letters in case the label is missing in configuration
	USAGE: <xsl:call-template name="SLSP-sincerely" /> -->
	<xsl:template name="SLSP-sincerely">
		<xsl:call-template name="SLSP-multilingual">
			<xsl:with-param name="en" select="'Sincerely,'"/>
			<xsl:with-param name="fr" select="'Meilleures salutations,'"/>
			<xsl:with-param name="it" select="'Cordiali saluti,'"/>
			<xsl:with-param name="de" select="'Freundliche Grüsse'"/>
		</xsl:call-template>
	</xsl:template>

	<!-- Prints the IZ message stored in label 'department' for the language of the letter.
		If value in the label is empty or with value "blank" does not print anything.
		The label can contain also HTML markup such as links or formatting.
		Warning: the label 'department' has to be available in the letter for this template to work	
		Usage:
			1. Configure the label department with text in all languages.
			2. Insert the template: <xsl:call-template name="IZMessage"/> -->
	<xsl:template name="IZMessage">
		<xsl:variable name="notice">@@department@@</xsl:variable>
		<xsl:if test="$notice != '' and $notice != 'blank'">
			<strong><xsl:call-template name="SLSP-multilingual"> <!-- recordTitle -->
				<xsl:with-param name="en" select="'Notice of the library'"/>
				<xsl:with-param name="fr" select="'Avis de la bibliothèque'"/>
				<xsl:with-param name="it" select="'Comunicazione della biblioteca'"/>
				<xsl:with-param name="de" select="'Notiz der Bibliothek'"/>
			</xsl:call-template>:</strong>&#160;<xsl:value-of select="$notice" disable-output-escaping="yes" />
		</xsl:if>
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