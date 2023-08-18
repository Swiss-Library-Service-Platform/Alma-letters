<?xml version="1.0" encoding="utf-8"?>
<!-- SLSP WG: Letters version 08/2021
10/2021	added template userAccount; removed labels for author and imprint
01/2022	SLSP-multilingual option for IZ with disabled languages
05/2022	added templates for extraction of volume, pages and request note in Resource Request Slip Letter
06/2022 added personal delivery field extraction
09/2022 Added templates SLSP-greeting and SLSP-sincerely
10/2022 Added templates SLSP-greeting-ILL; updated SLSP-multilingual
11/2022	Added template SLSP-Rapido-destination
05/2023 Added template SLSP-Rapido-pod-name
		Adapted labels for template SLSP-userAccount
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
			<xsl:with-param name="en" select="'To check your current loans and fees, please log in to swisscovery: '"/>
			<!-- Adaptation to include single quote in "n'ont" in the text -->
			<xsl:with-param name="fr">
				<![CDATA[Pour consulter vos prêts en cours et les frais, veuillez vous connecter à swisscovery: ]]>
			</xsl:with-param>
			<xsl:with-param name="it" select="'Per controllare i suoi prestiti attuali e i costi, effettui il login su swisscovery: '"/>
			<xsl:with-param name="de" select="'Um Ihre aktuellen Ausleihen und Gebühren zu überprüfen, loggen Sie sich bitte bei swisscovery ein: '"/>
		</xsl:call-template>
		<a>
			<xsl:attribute name="href">@@email_my_account@@&#38;lang=<xsl:value-of select="/notification_data/receivers/receiver/preferred_language"/></xsl:attribute>
			<xsl:attribute name="target">_blank</xsl:attribute>
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

	<!-- Template for Resource Request Slip Letter to extract the pod name
	Usage:
		<xsl:variable name="podName">
			<xsl:call-template name="SLSP-Rapido-pod-name" />
		</xsl:variable>
		<xsl:value-of select="$podName"/>-->
	<xsl:template name="SLSP-Rapido-pod-name">
		<xsl:if test="/notification_data/pod_name != ''">
			<xsl:value-of select="/notification_data/pod_name"/>
		</xsl:if>
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

	<!-- Template that returns True if library code passed in parameter is part of SLSP Bursar.
	Library codes that are part of SLSP Bursar can be obtained from SLSP Directories
	Usage:
		<xsl:variable name="isBursar">
			<xsl:call-template name="SLSP-Bursar-library">
				<xsl:with-param name="library" select="/notification_data/organization_unit/code"/>
			</xsl:call-template>
		</xsl:variable>
		<xsl:if test="$isBursar = 'true'">
			...
		</xsl:if>
 -->
	<xsl:template name="SLSP-Bursar-library">
		<xsl:param name="library" />
		<!-- add ";" behind the last library code in the list -->
		<xsl:variable name="bursar_libraries">
			A322;E79;A351;A300;A152;A310;A332;A342;A258;A100;A140;A170;A260;A125;A130;A192;A230;A354;A198;A259;A216;A246;A248;A366;E03;B408;B517;B432;B412;B569;E30;B405;B466;B467;B465;B464;B452;B583;B531;B555;B554;B404;B552;B527;B415;B400;B591;B410;B540;B500;B571;B589;B599;B521;B542;B433;E25;E59;N04;E71;N05;B420;N06;E56;N07;LUBIB;IUFFP;BIG;B418;E04;B425;N12;vge_baa;une_droit;vge_bge;une_ethno;une_ids;une_bflsh;une_bsci;une_pam7;une_seco;une_cies;vge_mar;B419;LUPIL;E33;vge_cjb;LUDAL;hes_edhea;E74;B437;E02;E92;E83;E16;E01;E27;E27;E60;E50;E44;E75;E39;uge_fhardt;BCUF_AEF;BCUF_AHP;BCUF_AVF;BCUF_BCC;BCUF_BCU;BCUF_BEF;BCUF_COF;BCUF_MAHF;BCUF_MAR;BCUF_MHN;BCUF_SAEF;BCUF_SBC;BCUF_SKJV;BCUF_TCF;BCUF_BFD;BCUF_IFF;BCUF_SDU;BCUF_BHAP;BCUF_BHT;BCUF_BLE;BCUF_BLL;BCUF_BLL-M;BCUF_BP2;BCUF_BP2;BCUF_DOKPE;BCUF_EOC;BCUF_IIEDH;BCUF_IPC;BCUF_MUS;BCUF_PSPE;BCUF_SCANT;BCUF_STS;BCUF_VCR;E06;une_gpsr;E76;E05;LUDOL;hes_arcca2;hes_arcca1;hes_arcsi;hes_headge;hes_hedsca;hes_hedsch;hes_vshevl;hes_vshesm;hes_vshevs;hes_vshevv;hes_hegge;hes_vsheso;hes_vsheso;E63;E61;E62;E62S;E62Y;hph_bjnbe;hph_bjnju;hph_bjnne;hph_frcd;E67;E41;hes_frhess;hes_frhess;hes_hetsge;hes_vsests;UHFH;HSG;SGSBI;HFR;HIFF;HIVW;HIWP;HMLE;HKMU;LUHGK;LUMHS;LUHSA;LUHTA;LUHLB;N08;E72;N09;LUKBW;LUKBS;LUKML;vge_bmu;E17;E08;E10;LUZHB;LUHSW;LUSBI;LUUHL;LUNI3;LUPHL;E64;LUXUN;MILAK;A296;vge_meg;vge_mhs;vge_mhn;LUNML;BFS;E07;E99;HFHS;LUPHS;LUPHP;LUPHZ;hph_frdz;HPHG;HPHS;HRDZJ;HRDZS;HRDZW;HPHRS;HRPMA;HPHRM;E09;UPHZH;UPBEB;LUPML;B424;E95;LUVOG;E45;E32;E19;une_serbib;E20;A150;SOSBI;BSSBK;LUSBK;SGSBK;UZSBK;Z0SBK;UZSBI;Z0SBI;LUSTA;LUSAR;une_sfm;E73;Z19;UAOI;UBFB;UBZH-EM;UIFE;UEZEN;UESZ;USIUZ;UJUD;UDS;UHS;UKPHS;UMLS;UKISP;UARCH;UIPMZ;UKHIS;UMBC;UFBI;Z14;UBOT;UPHIL;UPHON;UIPZ;UVK;UUFG;UPSYC;Z16;UROSE;ULING;UKOMP;Z18;UTS;UUSZB;UVET;UVMZ;UECON;UFSW;uge_acar;uge_aaca;uge_aobs;uge_abels;uge_abbat;uge_bcen;uge_cmu;uge_dbu;uge_mail;USLZ;USUEZ;UZZZZ;UBME;ULEHR;UPIM;Z01;Z06;Z02;Z03;Z04;Z05;UMWI;Z08;E57;E51;E97;E65;LUHSI;
		</xsl:variable>
		<xsl:choose>
			<xsl:when test="contains(concat($bursar_libraries, ';'), $library)">
				<xsl:value-of select="'true'"/>
			</xsl:when>
			<xsl:otherwise>
				<xsl:value-of select="'false'"/>
			</xsl:otherwise>
		</xsl:choose>
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