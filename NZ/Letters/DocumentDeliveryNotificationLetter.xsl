<?xml version="1.0" encoding="utf-8"?>
<!-- SLSP WG: Letters version 05/2022
      05/2022 Rapido: request metadata, info about providing library, max views message
      10/2022 Rapido: adjusted the providing library part; unified greeting
      10/2022 Added template for SLSP greeting
      01/2023 Rapido: hide digitizing library row if lender library is empty
      03/2023 Fixed linking for docDel with URL
      05/2023 Added IZ message template; adapted formatting of the letter
      12/2023 Fixed display of the digitizing library
      02/2025 Differentiation for the download link depending on the user group and primary id
              Added message for inst. accounts with login issue-->
<!-- Dependance:
		recordTitle - SLSP-multilingual, SLSP-userAccount, SLSP-greeting, SLSP-IZMessage
		style - generalStyle, bodyStyleCss
		header - head
		senderReceiver - senderReceiver
		-->
<xsl:stylesheet version="1.0"
xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
  <xsl:include href="header.xsl" />
  <xsl:include href="senderReceiver.xsl" />
  <xsl:include href="mailReason.xsl" />
  <xsl:include href="footer.xsl" />
  <xsl:include href="style.xsl" />
  <xsl:include href="recordTitle.xsl" />
  <xsl:variable name="conta1">0</xsl:variable>
  <xsl:variable name="stepType" select="/notification_data/request/work_flow_entity/step_type" />
  <xsl:variable name="externalRequestId" select="/notification_data/external_request_id" />
  <xsl:variable name="externalSystem" select="/notification_data/external_system" />
  <xsl:variable name="isDeposit" select="/notification_data/request/deposit_indicator" />
  <xsl:variable name="isDigitalDocDelivery" select="/notification_data/digital_document_delivery" />

  <!-- template to show link to SLSP fees info page
	The lang parameter for URL is used from the user preferred language
	Depends on:
		recordTitle - SLSP-multilingual
	USAGE: <xsl:call-template name="pricing-swisscovery"/>
	 -->
	<xsl:template name="pricing-swisscovery">
		<xsl:call-template name="SLSP-multilingual">
			<xsl:with-param name="en" select="'For general information about pricing for delivery please see: '"/>
			<!-- Adaptation to include single quote in "n'ont" in the text -->
			<xsl:with-param name="fr">
				<![CDATA[Pour des informations générales sur la tarification de la livraison, veuillez consulter: ]]>
			</xsl:with-param>
			<xsl:with-param name="it" select="'Per informazioni generali sulle tariffe si prega di consultare: '"/>
			<xsl:with-param name="de" select="'Allgemeine Informationen zu den Preisen für die Lieferung finden Sie unter: '"/>
		</xsl:call-template>
		<a>
			<xsl:attribute name="href">https://slsp.ch/<xsl:value-of select="/notification_data/receivers/receiver/preferred_language"/>/fees</xsl:attribute>
			<xsl:attribute name="target">
				_blank
			</xsl:attribute>
			<xsl:call-template name="SLSP-multilingual">
				<xsl:with-param name="en" select="'https://slsp.ch/en/fees'"/>
				<xsl:with-param name="fr" select="'https://slsp.ch/fr/fees'"/>
				<xsl:with-param name="it" select="'https://slsp.ch/it/fees'"/>
				<xsl:with-param name="de" select="'https://slsp.ch/de/fees'"/>
			</xsl:call-template>
		</a>
	</xsl:template>

  <!-- Template to extract chapter from the encoded XML metadata provided in letter -->
  <xsl:template name="extract-chapter">
    <xsl:variable name="user-chapter-temp" select="substring-after(/notification_data/resource_sharing_request/request_metadata, 'dc:rlterms_chapter_title&gt;')"/>
    <xsl:value-of select="substring-before($user-chapter-temp, '&lt;/dc:rlterms_chapter_title')"/>
  </xsl:template>

<!-- Prints the IZ message stored in label 'department' for the language of the letter.
		If value in the label is empty or with value "blank" does not print anything.
		The label can contain also HTML markup such as links or formatting.
		Usage:
			1. Configure the label department with text in all languages.
			2. <<already done by SLSP in this letter>>Insert the template: <xsl:call-template name="SLSP-IZMessage"/> -->
<xsl:template name="SLSP-IZMessage">
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

<!-- Checks the node notification_data/user_for_printing.
 If the user_group's value equals exactly 01 or 02 or 03 or 04 or 05, return "eduid".
 If the user_group's value equals exactly any digits between 11-18 or 91-92, return "slsp-internal"
 If the user_group's value equals anything else, but has @eduid.ch in the primary identifier, return "eduid"
 If the user_group's value equals anything else, return "internal"-->
<xsl:template name="accountType">
  <!-- create a variable prim_id_is_eduID if there is a children of notification_data/user_for_printing/identifiers/
   if there is a child node code_value that has a child <code>Primary Identifier</code>
   and a child value containing "@eduid.ch", set the variable as true -->
  <xsl:variable name="prim_id_is_eduID" select="/notification_data/user_for_printing/identifiers/code_value[code='Primary Identifier' and value[contains(., '@eduid.ch')]]"/>
  <xsl:choose>
    <xsl:when test="notification_data/user_for_printing/user_group = '01' or notification_data/user_for_printing/user_group = '02' or notification_data/user_for_printing/user_group = '03' or notification_data/user_for_printing/user_group = '04' or notification_data/user_for_printing/user_group = '05'">
      <xsl:text>eduid</xsl:text>
    </xsl:when>
    <xsl:when test="notification_data/user_for_printing/user_group &gt;= '11' and notification_data/user_for_printing/user_group &lt;= '18' or notification_data/user_for_printing/user_group &gt;= '91' and notification_data/user_for_printing/user_group &lt;= '92'">
      <xsl:text>slsp-internal</xsl:text>
    </xsl:when>
    <xsl:when test="$prim_id_is_eduID">
      <xsl:text>eduid</xsl:text>
    </xsl:when>
    <xsl:otherwise>
      <xsl:text>internal</xsl:text>
    </xsl:otherwise>
  </xsl:choose>
  <!-- Debug: Primary ID node
  <br/>
  <xsl:text>Prim id: <xsl:value-of select="$prim_id_is_eduID"/></xsl:text>
  <br/> -->
  <!-- Debug: true if prim_id_is_eduID is not empty -->
  <!-- <xsl:if test="$prim_id_is_eduID">
    <xsl:text>Prim id is eduID</xsl:text>
  </xsl:if> -->
</xsl:template>

<!-- style using css to style <a> to look like a button -->
<xsl:template name="download-button-class">
  <style>
    .slsp-download-button {
      background-color: #4E4A99; /* SLSP purple */
      border: none;
      color: white !important;
      text-align: center;
      text-decoration: none;
      display: inline-block;
      font-size: 120%;
      font-weight: 600;
      margin: 0;
      cursor: pointer;
      padding: 0 12px;
      border-radius: 3px;
      line-height: 48px;
    }
  </style>
</xsl:template>


  <xsl:template match="/">
    <html>
      <head>
        <xsl:call-template name="generalStyle" />
        <xsl:call-template name="download-button-class"/>
      </head>
      <body>
        <xsl:attribute name="style">
          <xsl:call-template name="bodyStyleCss" />
        </xsl:attribute>
        <xsl:call-template name="head" />
        <xsl:call-template name="senderReceiver" />
        <xsl:variable name="userType">
          <xsl:call-template name="accountType"/>
        </xsl:variable>
        <div class="messageArea">
          <div class="messageBody">

          	<table cellspacing="0" cellpadding="5" border="0">
              <!-- DEBUG
              <tr>
                <td>
                  Account type: <xsl:call-template name="accountType"/>
                </td>
              </tr> -->
              <tr>
                <td>
                  <xsl:call-template name="SLSP-greeting" />
                </td>
              </tr>
          		<tr>
                <td>@@your_request@@<br/><br />
                  <xsl:call-template name="recordTitle"/>
                  <xsl:choose>
                    <!-- Alma DocDel request -->
                    <xsl:when test="notification_data/request != ''">
                      <xsl:if test="notification_data/phys_item_display/issue_level_description !='' and notification_data/phys_item_display/issue_level_description != 'Vol.' and notification_data/phys_item_display/issue_level_description != '_'">
                        <xsl:call-template name="SLSP-multilingual">
                          <xsl:with-param name="en" select="'Description'"/>
                          <xsl:with-param name="fr" select="'Description'"/>
                          <xsl:with-param name="it" select="'Descrizione'"/>
                          <xsl:with-param name="de" select="'Beschreibung'"/>
                        </xsl:call-template>: <xsl:value-of select="notification_data/phys_item_display/issue_level_description"/><br />
                      </xsl:if>
                      <xsl:if test="notification_data/request/chapter_article_title !=''">
                        <xsl:call-template name="SLSP-multilingual">
                          <xsl:with-param name="en" select="'Article / Chapter'"/>
                          <xsl:with-param name="fr" select="'Article / Chapitre'"/>
                          <xsl:with-param name="it" select="'Articolo / Capitolo'"/>
                          <xsl:with-param name="de" select="'Artikel / Kapitel'"/>
                        </xsl:call-template>: <xsl:value-of select="notification_data/request/chapter_article_title" /><br />
                      </xsl:if>
                      <xsl:if test="notification_data/request/pages !=''">
                        <xsl:call-template name="SLSP-multilingual">
                          <xsl:with-param name="en" select="'Pages'"/>
                          <xsl:with-param name="fr" select="'Pages'"/>
                          <xsl:with-param name="it" select="'Pagine'"/>
                          <xsl:with-param name="de" select="'Seiten'"/>
                        </xsl:call-template>: <xsl:value-of select="/notification_data/request/pages" /><br />
                      </xsl:if>
                      <xsl:if test="notification_data/request/note !=''">
                        <xsl:call-template name="SLSP-multilingual">
                          <xsl:with-param name="en" select="'Request note'"/>
                          <xsl:with-param name="fr" select="'Note de demande	'"/>
                          <xsl:with-param name="it" select="'Nota di richiesta'"/>
                          <xsl:with-param name="de" select="'Bestell-Notiz'"/>
                        </xsl:call-template>: <xsl:value-of select="/notification_data/request/note" /><br />
                      </xsl:if>
                    </xsl:when>
                    <!-- Rapido DocDel request -->
                    <xsl:when test="notification_data/resource_sharing_request != ''">
                      <xsl:variable name="requestVolume">
                        <xsl:call-template name="SLSP-Rapido-extract-volume" />
                      </xsl:variable>
                      <xsl:variable name="user-chapter">
                        <xsl:call-template name="extract-chapter" />
                      </xsl:variable>
                      <xsl:variable name="requestPages">
                        <xsl:call-template name="SLSP-Rapido-extract-pages" />
                      </xsl:variable>

                      <xsl:if test="$requestVolume !=''">
                        <xsl:call-template name="SLSP-multilingual">
                          <xsl:with-param name="en" select="'Description'"/>
                          <xsl:with-param name="fr" select="'Description'"/>
                          <xsl:with-param name="it" select="'Descrizione'"/>
                          <xsl:with-param name="de" select="'Beschreibung'"/>
                        </xsl:call-template>: Vol. <xsl:value-of select="$requestVolume"/><br />
                      </xsl:if>

                      <xsl:if test="$user-chapter !=''">
                        <xsl:call-template name="SLSP-multilingual">
                          <xsl:with-param name="en" select="'Article / Chapter'"/>
                          <xsl:with-param name="fr" select="'Article / Chapitre'"/>
                          <xsl:with-param name="it" select="'Articolo / Capitolo'"/>
                          <xsl:with-param name="de" select="'Artikel / Kapitel'"/>
                        </xsl:call-template>: <xsl:value-of select="$user-chapter" /><br />
                      </xsl:if>

                      <xsl:if test="$requestPages !=''">
                        <xsl:call-template name="SLSP-multilingual">
                          <xsl:with-param name="en" select="'Pages'"/>
                          <xsl:with-param name="fr" select="'Pages'"/>
                          <xsl:with-param name="it" select="'Pagine'"/>
                          <xsl:with-param name="de" select="'Seiten'"/>
                        </xsl:call-template>: <xsl:value-of select="$requestPages" /><br />
                      </xsl:if>

                      <xsl:if test="notification_data/resource_sharing_request/note !=''">
                        <xsl:call-template name="SLSP-multilingual">
                          <xsl:with-param name="en" select="'Request note'"/>
                          <xsl:with-param name="fr" select="'Note de demande	'"/>
                          <xsl:with-param name="it" select="'Nota di richiesta'"/>
                          <xsl:with-param name="de" select="'Bestell-Notiz'"/>
                        </xsl:call-template>: <xsl:value-of select="/notification_data/resource_sharing_request/note" /><br />
                      </xsl:if>
                    </xsl:when>
                  </xsl:choose>
                </td> 
              </tr>
            <!-- RapidILL library that scanned the item -->
            <xsl:if test="notification_data/resource_sharing_request != ''
              and notification_data/resource_sharing_request/lending_institution != ''">
              <tr>
                <td>
                    <xsl:call-template name="SLSP-multilingual">
                        <xsl:with-param name="en" select="'The digital copy is provided by'"/>
                        <xsl:with-param name="fr" select="'La version numérique est fournie par '"/>
                        <xsl:with-param name="it" select="'La versione digitale è fornita da'"/>
                        <xsl:with-param name="de" select="'Die digitale Version wird bereitgestellt von'"/>
                    </xsl:call-template>: <xsl:value-of select="notification_data/resource_sharing_request/lending_institution"/>
                    (<xsl:call-template name="SLSP-multilingual">
                        <xsl:with-param name="en" select="'Please note that digitization fees, if applicable, will be charged by this library.'"/>
                        <xsl:with-param name="fr" select="'Veuillez noter que les frais de numérisation, le cas échéant, seront facturés par cette bibliothèque.'"/>
                        <xsl:with-param name="it" select="'Si prega di notare che i costi di digitalizzazione, se applicabili, saranno addebitati da questa biblioteca.'"/>
                        <xsl:with-param name="de" select="'Bitte beachten Sie, dass die Bibliothek ggf. Digitalisierungsgebühren erhebt.'"/>
                    </xsl:call-template>)
                </td>
              </tr>
              </xsl:if>
              <xsl:choose>
                <xsl:when test="/notification_data/url_list != ''">
                  <tr>
                    <td>@@attached_are_the_urls@@:</td>
                  </tr>
                  <tr>
                    <td>
                      <ul>
                        <xsl:for-each select="/notification_data/url_list/string">
                          <li>
                            <!-- Obsolete
                            <xsl:variable name="index" select="position()"/>
                            <xsl:if test="$index != '1'">
                              <br/>
                            </xsl:if>
                            <xsl:variable name="linkText" select="concat('Link ', $index)"/> -->
                            <!-- if the node has //, extract substring-after //, otherwise keep whole string -->
                            <xsl:variable name="linkNoHttps">
                              <xsl:choose>
                                <xsl:when test="contains(., '//')">
                                  <xsl:value-of select="substring-after(.,'//')"/>
                                </xsl:when>
                                <xsl:otherwise>
                                  <xsl:value-of select="."/>
                                </xsl:otherwise>
                              </xsl:choose>
                            </xsl:variable>
                            <xsl:variable name="linkDomain">
                              <xsl:choose>
                                <xsl:when test="contains($linkNoHttps, '/')">
                                  <xsl:value-of select="substring-before($linkNoHttps,'/')"/>
                                </xsl:when>
                                <xsl:otherwise>
                                  <xsl:value-of select="$linkNoHttps"/>
                                </xsl:otherwise>
                              </xsl:choose>
                            </xsl:variable>
                            
                            <xsl:variable name="linkDestination" select="substring-after($linkNoHttps,'/')"/>
                            <!-- extract last 30 characters from $linkDestination -->
                            <xsl:variable name="linkDestinationShort">
                              <xsl:choose>
                                <xsl:when test="string-length($linkDestination) &gt; 30">
                                  <xsl:value-of select="concat('...', substring($linkDestination, string-length($linkDestination) - 30))"/>
                                </xsl:when>
                                <xsl:otherwise>
                                  <xsl:value-of select="$linkDestination"/>
                                </xsl:otherwise>
                              </xsl:choose>
                            </xsl:variable>
                            <xsl:variable name="linkText">
                              <xsl:choose>
                                <xsl:when test="string-length($linkDestinationShort) != 0">
                                  <xsl:value-of select="$linkDomain"/>/<xsl:value-of select="$linkDestinationShort"/>
                                </xsl:when>
                                <xsl:otherwise>
                                  <xsl:value-of select="$linkDomain"/>
                                </xsl:otherwise>
                              </xsl:choose>
                            </xsl:variable>
                            <!-- DEBUG
                            Link no HTTPS: <xsl:value-of select="$linkNoHttps"/><br/>
                            Link domain: <xsl:value-of select="$linkDomain"/><br/>
                            Link destination: <xsl:value-of select="$linkDestinationShort"/><br/> -->
                            <a>
                              <xsl:attribute name="href"><xsl:value-of select="."/></xsl:attribute>
                              <xsl:attribute name="alt"><xsl:value-of select="$linkDomain"/></xsl:attribute>
                              <xsl:attribute name="title"><xsl:value-of select="$linkDomain"/></xsl:attribute>
                              <xsl:attribute name="target"><xsl:value-of select="_blank"/></xsl:attribute>
                              <xsl:value-of select="$linkText"/>
                            </a>
                          </li>
                        </xsl:for-each>
                      </ul>
                    </td>
                  </tr>
                </xsl:when>
                <xsl:otherwise>
                  <!-- <tr>
                    <td>@@to_see_the_resource@@</td>
                  </tr> -->
                  <tr>
                    <td>
                      <xsl:choose>
                      <!-- add message to institutional accounts using the @@to_see_the_resource@@ label -->
                        <xsl:when test="$userType = 'eduid'">
                          <a class="slsp-download-button"><xsl:attribute name="href"><xsl:value-of select="notification_data/download_url_saml" /></xsl:attribute>@@click_here@@</a>
                        </xsl:when>
                        <xsl:when test="$userType = 'slsp-internal' or $userType = 'internal'">
                          <a class="slsp-download-button"><xsl:attribute name="href"><xsl:value-of select="notification_data/download_url_local" /></xsl:attribute>@@click_here@@</a>
                          <br />
                          <i>
                          <xsl:call-template name="SLSP-multilingual">
                            <xsl:with-param name="en" select="'If you can’t login and/or download the file, please '" />
                            <xsl:with-param name="fr">
                              <![CDATA[Si vous ne pouvez pas vous connecter et/ou télécharger le fichier, veuillez vous ]]>
                            </xsl:with-param>
                            <xsl:with-param name="it" select="'Se non riesci a effettuare il login e/o scaricare il file, per favore'" />
                            <xsl:with-param name="de" select="'Wenn Sie sich nicht einloggen und/oder die Datei nicht herunterladen können, '" />
                          </xsl:call-template> 
                          <a>
                            <xsl:attribute name="href">@@email_my_account@@&#38;lang=<xsl:value-of
                                select="/notification_data/receivers/receiver/preferred_language" /></xsl:attribute>
                            <xsl:attribute name="target">_blank</xsl:attribute>
                            <xsl:call-template name="SLSP-multilingual">
                              <xsl:with-param name="en" select="'login to your library account'" />
                              <xsl:with-param name="fr">
                                <![CDATA[connecter à votre compte de bibliothèque]]></xsl:with-param>
                              <xsl:with-param name="it" select="'accedi al tuo account della biblioteca'" />
                              <xsl:with-param name="de" select="'melden Sie sich bitte bei Ihrem Bibliothekskonto an'" />
                            </xsl:call-template>
                          </a>
                          <xsl:call-template name="SLSP-multilingual">
                            <xsl:with-param name="en" select="'and then try again.'" />
                            <xsl:with-param name="fr"><![CDATA[, puis réessayez.]]>
                            </xsl:with-param>
                            <xsl:with-param name="it" select="'e poi riprova.'" />
                            <xsl:with-param name="de" select="'und versuchen Sie es erneut.'" />
                          </xsl:call-template></i>
                        </xsl:when>
                      </xsl:choose>
                      <br/>
                      <br/>
                      <xsl:choose>
                        <!-- non-rapido request -->
                        <xsl:when test="notification_data/request/document_delivery_max_num_of_view != ''">
                          @@max_num_of_views@@ <xsl:value-of select="notification_data/request/document_delivery_max_num_of_views"/>.
                        </xsl:when>
                        <!-- Rapido request -->
                        <xsl:when test="notification_data/borrowing_document_delivery_max_num_of_views != ''">
                          @@max_num_of_views@@ <xsl:value-of select="notification_data/borrowing_document_delivery_max_num_of_views"/>.
                        </xsl:when>
                      </xsl:choose>
                    </td>
                  </tr>                  
                </xsl:otherwise>
              </xsl:choose>
              <tr>
                <td>
                  <xsl:call-template name="SLSP-IZMessage"/>
                </td>
              </tr>
              <tr>
                <td>
                  <xsl:call-template name="SLSP-userAccount"/>
                </td>
              </tr>
              <tr>
                <td>
                  <xsl:call-template name="pricing-swisscovery"/>
                </td>
              </tr>
              <tr>
                <td>@@sincerely@@ <br/>
                  <xsl:value-of select="notification_data/organization_unit/name" /></td>
              </tr>
              <tr>
                <td><br/><i>powered by SLSP</i></td>
              </tr>
          	</table>
          </div>
        </div>
      </body>
    </html>
  </xsl:template>
</xsl:stylesheet>