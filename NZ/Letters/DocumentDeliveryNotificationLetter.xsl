<?xml version="1.0" encoding="utf-8"?>
<!-- SLSP WG: Letters version 05/2022
      05/2022 Rapido: request metadata, info about providing library, max views message
      10/2022 Rapido: adjusted the providing library part; unified greeting
      10/2022 Added template for SLSP greeting
      01/2023 Rapido: hide digitizing library row if lender library is empty
      03/2023 Fixed linking for docDel with URL
      04/2023 Added IZ message template-->
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

  <xsl:template match="/">
    <html>
      <head>
        <xsl:call-template name="generalStyle" />
      </head>
      <body>
        <xsl:attribute name="style">
          <xsl:call-template name="bodyStyleCss" />
        </xsl:attribute>
        <xsl:call-template name="head" />
        <xsl:call-template name="senderReceiver" />
        <div class="messageArea">
          <div class="messageBody">

          	<table cellspacing="0" cellpadding="5" border="0">
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
                          and notification_data/resource_sharing_request/self_ownership = 'false'
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
                    <td><br />@@attached_are_the_urls@@:</td>
                  </tr>
                  <tr>
                    <td>
                      <xsl:for-each select="/notification_data/url_list/string">
                        <xsl:variable name="index" select="position()"/>
                        <xsl:if test="$index != '1'">
                          <br/>
                        </xsl:if>
                        <xsl:variable name="linkText" select="concat('Link ', $index)"/>
                        <xsl:variable name="linkNoHttps" select="substring-after(.,'//')"/>
                        <xsl:variable name="linkDomain" select="substring-before($linkNoHttps,'/')"/>
                        <a>
                          <xsl:attribute name="href"><xsl:value-of select="."/></xsl:attribute>
                          <xsl:attribute name="alt"><xsl:value-of select="concat($linkText, ': ', $linkDomain)"/></xsl:attribute>
                          <xsl:attribute name="title"><xsl:value-of select="$linkDomain"/></xsl:attribute>
                          <xsl:attribute name="target"><xsl:value-of select="_blank"/></xsl:attribute>
                          <xsl:value-of select="$linkText"/>
                        </a>
                      </xsl:for-each>
                    </td>
                  </tr>
                </xsl:when>
                <xsl:otherwise>
                  <tr>
                    <td><br />@@to_see_the_resource@@</td>
                  </tr>
                  <tr>
                    <td>@@for_local_users@@&#160;<a><xsl:attribute name="href"><xsl:value-of select="notification_data/download_url_local" /></xsl:attribute>@@click_here@@</a></td>
                  </tr>
                  <tr>
                    <td>@@for_saml_users@@&#160;<a><xsl:attribute name="href"><xsl:value-of select="notification_data/download_url_saml" /></xsl:attribute>@@click_here@@</a></td>
                  </tr>
                  <xsl:choose>
                      <!-- non-rapido request -->
                      <xsl:when test="notification_data/request/document_delivery_max_num_of_view != ''">
                        <tr>
                          <td>@@max_num_of_views@@ <xsl:value-of select="notification_data/request/document_delivery_max_num_of_views"/>.</td>
                        </tr>
                      </xsl:when>
                      <!-- Rapido request -->
                      <xsl:when test="notification_data/borrowing_document_delivery_max_num_of_views != ''">
                        <tr>
                          <td>@@max_num_of_views@@ <xsl:value-of select="notification_data/borrowing_document_delivery_max_num_of_views"/>.</td>
                        </tr>
                      </xsl:when>
                  </xsl:choose>
                </xsl:otherwise>
              </xsl:choose>
              <tr>
                <td>
                  <br />
                  <xsl:call-template name="SLSP-IZMessage"/>
                </td>
              </tr>
              <tr>
                <td>
                  <br />
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