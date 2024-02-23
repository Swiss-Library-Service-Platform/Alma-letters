<?xml version="1.0" encoding="utf-8" standalone="no" ?>
<!-- SLSP Main version 10/2023

    Dependance:
    header - head
    style - generalStyle, bodyStyleCss
    recordTitle - SLSP-multilingual, SLSP-greeting-ILL, SLSP-sincerely

-->
<xsl:stylesheet version="1.0"
xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
<xsl:output method="xml" encoding="utf-8" indent="yes"
		doctype-system="http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd"
		doctype-public="-//W3C//DTD XHTML 1.0 Transitional//EN" />
  <xsl:include href="header.xsl" />
  <xsl:include href="senderReceiver.xsl" />
  <xsl:include href="mailReason.xsl" />
  <xsl:include href="footer.xsl" />
  <xsl:include href="style.xsl" />
  <xsl:include href="recordTitle.xsl" />

  <!--Fix to transform the note coming from Alma UI to insert new lines
		Takes the parameter text and replaces new lines with <br/> 
	Source: https://stackoverflow.com/questions/561235/xslt-replace-n-with-br-only-in-one-node
		@Tomalak, CC-BY-SA 3.0
	-->
	<xsl:template name="break">
		<xsl:param name="text" select="string(.)"/>
		<xsl:choose>
			<xsl:when test="contains($text, '&#xa;')">
			<xsl:value-of select="substring-before($text, '&#xa;')"/>
			<br/>
			<xsl:call-template name="break">
				<xsl:with-param 
				name="text" 
				select="substring-after($text, '&#xa;')"
				/>
			</xsl:call-template>
			</xsl:when>
			<xsl:otherwise>
			<xsl:value-of select="$text"/>
			</xsl:otherwise>
		</xsl:choose>
	</xsl:template>

    <!--
    Workaround template for header until Ex Libris fixes the letter
    -->
    <xsl:template name="head-workaround">
        <table cellspacing="0" cellpadding="5" border="0">
            <!-- SLSP: overloading the height parameter to overwrite the style -->
            <xsl:attribute name="style">
                <xsl:call-template name="headerTableStyleCss" />; height: 35mm;
            </xsl:attribute>
            <!-- LOGO INSERT -->
            <tr>
            <xsl:attribute name="style">
                <xsl:call-template name="headerLogoStyleCss" /> <!-- style.xsl -->
            </xsl:attribute>
                <td colspan="2">
                <div id="mailHeader">
                    <div id="logoContainer" class="alignLeft">
                        <!-- SLSP: fixed height of logo -->
                        <img onerror="this.src='/infra/branding/logo/logo-email.png'" src="cid:logo.jpg" alt="logo" style="height:20mm"/>
                    </div>
                </div>
                </td>
            </tr>
        <!-- END OF LOGO INSERT -->
            <tr>
                <xsl:for-each select="notification_data/general_data">
                    <td>
                        <h1><xsl:value-of select="subject"/></h1>
                    </td>
                    <td align="right">
                        <xsl:value-of select="current_date"/>
                    </td>
                </xsl:for-each>
            </tr>
        </table>
    </xsl:template>

  <xsl:template match="/">
    <html>
        <head>
            <xsl:call-template name="generalStyle" />
        </head>
        <body>
        <xsl:attribute name="style">
            <xsl:call-template name="bodyStyleCss" /><!-- style.xsl -->
        </xsl:attribute>

        <xsl:call-template name="head-workaround" />

        <div class="messageArea">
            <div class="messageBody">
                <table cellspacing="0" cellpadding="5" border="0">
                    <tr>
                        <td>
                            <xsl:call-template name="SLSP-greeting-ILL" />
                        </td>
                    </tr>
                    <tr>
                        <td>
                            <br />
                            <xsl:call-template name="SLSP-multilingual"> <!-- recordTitle -->
                                <xsl:with-param name="en" select="'You received a new feedback.'"/>
                                <xsl:with-param name="fr" select="'Il y a un nouveau feedback.'"/>
                                <xsl:with-param name="it" select="'Un nuovo feedback da parte.'"/>
                                <xsl:with-param name="de" select="'Es gibt ein neues Feedback.'"/>
                            </xsl:call-template>
                        </td>
                    </tr>
                    <xsl:if test="/notification_data/problem_description != ''">
                        <tr>
                            <td>
                                <strong><xsl:call-template name="SLSP-multilingual"> <!-- recordTitle -->
                                    <xsl:with-param name="en" select="'Problem description'"/>
                                    <xsl:with-param name="fr" select="'Description du problème'"/>
                                    <xsl:with-param name="it" select="'Descrizione del problema'"/>
                                    <xsl:with-param name="de" select="'Beschreibung des Problems'"/>
                                </xsl:call-template>: </strong><br />
                                <xsl:call-template name="break">
                                    <xsl:with-param name="text" select="/notification_data/problem_description"/>
                                </xsl:call-template>
                            </td>
                        </tr>
                    </xsl:if>
                    <xsl:if test="/notification_data/user_email != ''">
                        <tr>
                            <td>
                                <strong><xsl:call-template name="SLSP-multilingual"> <!-- recordTitle -->
                                    <xsl:with-param name="en" select="'User e-mail'"/>
                                    <xsl:with-param name="fr">
                                        <![CDATA[E-mail de l'utilisateur]]>
                                    </xsl:with-param>
                                    <xsl:with-param name="it">
                                        <![CDATA[E-mail dell'utente]]>
                                    </xsl:with-param>
                                    <xsl:with-param name="de" select="'Benutzer-E-Mail'"/>
                                </xsl:call-template>: </strong><xsl:value-of select="/notification_data/user_email" />
                            </td>
                        </tr>
                    </xsl:if>
                    <tr>
                        <td>
                            <strong><xsl:call-template name="SLSP-multilingual"> <!-- recordTitle -->
                                <xsl:with-param name="en" select="'Relevant URL'"/>
                                <xsl:with-param name="fr" select="'URL pertinent'"/>
                                <xsl:with-param name="it" select="'URL pertinente'"/>
                                <xsl:with-param name="de" select="'Relevante URL'"/>
                            </xsl:call-template>: </strong><a>
                                <xsl:attribute name="href">
                                    <xsl:value-of select="/notification_data/relevant_url" />
                                </xsl:attribute>
                                <xsl:attribute name="target">_blank</xsl:attribute>
                                <xsl:value-of select="/notification_data/relevant_url" />
                            </a>
                        </td>
                    </tr>
                    <xsl:if test="/notification_data/browser != ''">
                        <tr>
                            <td>
                                <strong><xsl:call-template name="SLSP-multilingual"> <!-- recordTitle -->
                                    <xsl:with-param name="en" select="'Browser'"/>
                                    <xsl:with-param name="fr" select="'Navigateur'"/>
                                    <xsl:with-param name="it" select="'Browser'"/>
                                    <xsl:with-param name="de" select="'Browser'"/>
                                </xsl:call-template>: </strong><xsl:value-of select="/notification_data/browser" />
                            </td>
                        </tr>
                    </xsl:if>
                    <xsl:if test="/notification_data/device != ''">
                        <tr>
                            <td>
                                <strong><xsl:call-template name="SLSP-multilingual"> <!-- recordTitle -->
                                    <xsl:with-param name="en" select="'User device'"/>
                                    <xsl:with-param name="fr">
                                        <![CDATA[Dispositif de l'utilisateur]]>
                                    </xsl:with-param>
                                    <xsl:with-param name="it">
                                        <![CDATA[Dispositivo dell'utente]]>
                                    </xsl:with-param>
                                    <xsl:with-param name="de" select="'Benutzergerät'"/>
                                </xsl:call-template>: </strong><xsl:value-of select="/notification_data/device" />
                            </td>
                        </tr>
                    </xsl:if>
                    <tr>
                        <td>
                            <br />
                            <xsl:call-template name="SLSP-sincerely" />
                        </td>
                    </tr>
                    <tr>
                        <td>
                            <xsl:value-of select="notification_data/organization_unit/name" />
                        </td>
                    </tr>
                </table>
            </div>
        </div>
        </body>
    </html>
	</xsl:template>
</xsl:stylesheet>