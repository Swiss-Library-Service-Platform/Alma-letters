<?xml version="1.0" encoding="utf-8"?>
<!-- 
    IZ customization: Delivery address on left side

    SLSP version 07/2022
    04/2022 - added delivery and sender addresses
    04/2022 - no logo, destination library on top
    04/2022 - hide issue field
    04/2022 - hide sincerely
    05/2022 - sender address as one line; formatted receiver address position with div
    06/2022 - letter types; logo, address and texts shown only for ILL
    07/2022 - request type does not print if pod_id is empty
    07/2022 - removed hello section in ILL
    -->
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="1.0">
	<xsl:include href="header.xsl"/>
	<xsl:include href="senderReceiver.xsl"/>
	<xsl:include href="mailReason.xsl"/>
	<xsl:include href="footer.xsl"/>
	<xsl:include href="style.xsl"/>
	<xsl:include href="recordTitle.xsl"/>

    <!-- insert transit header without logo -->
    <xsl:template name="head-letterName-only-return-slip">
        <table cellspacing="0" cellpadding="5" border="0">
            <!-- overloading the height parameter to overwrite the style -->
            <xsl:attribute name="style">
                <xsl:call-template name="headerTableStyleCss" />; height: 35mm;
            </xsl:attribute>
            <tr>
            <xsl:attribute name="style">
                <xsl:call-template name="headerLogoStyleCss" /> <!-- style.xsl -->
            </xsl:attribute>
                <td>
                    <span style="font-size: 160%; font-weight: bold">&#x21e8;
                        <xsl:value-of select="notification_data/partner_name" />
                    </span>
                </td>
            </tr>
            <tr>
                <td>
                    <h1><xsl:value-of select="/notification_data/general_data/subject"/></h1>
                </td>
            </tr>
        </table>
        
        <!-- <span style="background-color:#e9e9e9; width:100%; height:30px; line-height: 30px; margin: 0 15 5 0;" id="head-letter-name">
            <span style="font-size: 170%; vertical-align: middle; text-shadow:1px 1px 1px #fff;">@@letterName@@</span>
        </span> -->
    </xsl:template>

    <!-- Template to return type of the request
	Possible request types:
		- ILL
		- Rapido
            - SLSP Courier
			- Personal Delivery
			- <local courier pod name> -->
    <xsl:template name="request-type">
        <xsl:for-each select="/notification_data/request">
            <!-- app_indicator = <xsl:value-of select="app_indicator"/><br/>
            pod_name = <xsl:value-of select="pod_name"/><br/> -->
            <xsl:choose>
                <xsl:when test="app_indicator = 'ALMA' and pod_name = ''">ILL</xsl:when><!-- ILL -->
                <xsl:when test="app_indicator = 'NGRS'"><!-- Rapido -->
                    <xsl:choose>
                        <!-- SLSP Courier -->
                        <xsl:when test="pod_name = 'SLSP Courier'">SLSP Courier</xsl:when>
                        <!-- Rapido personal deliery
                            Not possible to distinguish a clear state when pod name empty -> do not print -->
                        <!-- <xsl:when test="pod_name = ''">Personal Delivery</xsl:when> -->
                        <!-- Local Courier -->
                        <xsl:when test="pod_name != ''"><xsl:value-of select="pod_name"/></xsl:when>
                    </xsl:choose>
                </xsl:when>
            </xsl:choose>
        </xsl:for-each>
    </xsl:template>

    <!-- Transit header with logo and without print date-->
    <xsl:template name="head-letterName-logo">
        <table cellspacing="0" cellpadding="5" border="0">
            <!-- overloading the height parameter to overwrite the style -->
            <xsl:attribute name="style">
                <xsl:call-template name="headerTableStyleCss" />; height: 35mm;
            </xsl:attribute>
            <tr>
            <xsl:attribute name="style">
                <xsl:call-template name="headerLogoStyleCss" /> <!-- style.xsl -->
            </xsl:attribute>
                <td>
                    <div id="mailHeader">
                        <div id="logoContainer" class="alignLeft">
                            <!-- SLSP: fixed height of logo -->
                            <img onerror="this.src='/infra/branding/logo/logo-email.png'" src="cid:logo.jpg" alt="logo" style="height:20mm"/>
                        </div>
                    </div>
                </td>
            </tr>
            <tr>
                <xsl:for-each select="notification_data/general_data">
                    <td>
                        <h1><xsl:value-of select="subject"/></h1>
                    </td>
                </xsl:for-each>
            </tr>
        </table>
        
        <!-- <span style="background-color:#e9e9e9; width:100%; height:30px; line-height: 30px; margin: 0 15 5 0;" id="head-letter-name">
            <span style="font-size: 170%; vertical-align: middle; text-shadow:1px 1px 1px #fff;">@@letterName@@</span>
        </span> -->
    </xsl:template>

    <!-- Template to generate the delivery address on right
        Does not display correctly when sent by e-mail but displays correctly in Alma. -->
    <xsl:template name="senderReceiver-returnSlip">
        <div style="position:relative; right: 0; font-weight: 600; font-size: 120%; width: 100mm;margin-left: auto;" align="right">
            <div style="padding: 10mm 22mm 10mm 5px;" align="left">
                <xsl:for-each select="/notification_data/partner_address">
                    <xsl:if test="string-length(line1)!=0">
                        <xsl:value-of select="line1"/><br />
                    </xsl:if>
                    <xsl:if test="string-length(line2)!=0">
                        <xsl:value-of select="line2"/><br />
                    </xsl:if>
                    <xsl:if test="string-length(line3)!=0">
                        <xsl:value-of select="line3"/><br />
                    </xsl:if>
                    <xsl:if test="string-length(line4)!=0">
                        <xsl:value-of select="line4"/><br />
                    </xsl:if>
                    <xsl:if test="string-length(line5)!=0">
                        <xsl:value-of select="line5"/><br />
                    </xsl:if>
                    <xsl:if test="postal_code != '' or city != ''">
                        
                            <xsl:if test="postal_code != ''">
                                <xsl:value-of select="postal_code"/>&#160;
                            </xsl:if>
                            <xsl:if test="city != ''">
                                <xsl:value-of select="city"/>
                            </xsl:if>
                        <br />
                    </xsl:if>
                    <xsl:if test="country_display != ''">
                        <xsl:value-of select="country_display"/>
                    </xsl:if>
                </xsl:for-each>
            </div>
        </div>
    </xsl:template>

    <!--Template to generate the delivery address on left
        Does not display correctly when sent by e-mail but displays correctly in Alma. -->
    <xsl:template name="senderReceiver-returnSlip-reversed">
        <div style="font-weight: 600; font-size: 120%; width: 100mm; margin-left: 19mm;">
            <div style="padding: 10mm 10mm 10mm 10mm;">
                <xsl:for-each select="/notification_data/partner_address">
                    <xsl:if test="string-length(line1)!=0">
                        <xsl:value-of select="line1"/><br />
                    </xsl:if>
                    <xsl:if test="string-length(line2)!=0">
                        <xsl:value-of select="line2"/><br />
                    </xsl:if>
                    <xsl:if test="string-length(line3)!=0">
                        <xsl:value-of select="line3"/><br />
                    </xsl:if>
                    <xsl:if test="string-length(line4)!=0">
                        <xsl:value-of select="line4"/><br />
                    </xsl:if>
                    <xsl:if test="string-length(line5)!=0">
                        <xsl:value-of select="line5"/><br />
                    </xsl:if>
                    <xsl:if test="postal_code != '' or city != ''">
                            <xsl:if test="postal_code != ''">
                                <xsl:value-of select="postal_code"/>&#160;
                            </xsl:if>
                            <xsl:if test="city != ''">
                                <xsl:value-of select="city"/>
                            </xsl:if>
                        <br />
                    </xsl:if>
                    <xsl:if test="country_display != ''">
                        <xsl:value-of select="country_display"/>
                    </xsl:if>
                </xsl:for-each>
            </div>
        </div>
    </xsl:template>

    <!-- Needs to be tested. Does not display correctly when sent by e-mail but displays correctly in Alma. -->
    <xsl:template name="senderReceiver-returnSlip-working">
        <div style="display: block; float: right; font-weight: 600; font-size: 120%; width: 81mm;margin-left: auto;" align="right">
            <div style="padding: 10mm 10mm 10mm 0; " align="left">
                <xsl:for-each select="/notification_data/partner_address">
                    <xsl:if test="string-length(line1)!=0">
                        <xsl:value-of select="line1"/><br />
                    </xsl:if>
                    <xsl:if test="string-length(line2)!=0">
                        <xsl:value-of select="line2"/><br />
                    </xsl:if>
                    <xsl:if test="string-length(line3)!=0">
                        <xsl:value-of select="line3"/><br />
                    </xsl:if>
                    <xsl:if test="string-length(line4)!=0">
                        <xsl:value-of select="line4"/><br />
                    </xsl:if>
                    <xsl:if test="string-length(line5)!=0">
                        <xsl:value-of select="line5"/><br />
                    </xsl:if>
                    <xsl:if test="postal_code != '' or city != ''">
                        
                            <xsl:if test="postal_code != ''">
                                <xsl:value-of select="postal_code"/>&#160;
                            </xsl:if>
                            <xsl:if test="city != ''">
                                <xsl:value-of select="city"/>
                            </xsl:if>
                        <br />
                    </xsl:if>
                    <xsl:if test="country_display != ''">
                        <xsl:value-of select="country_display"/>
                    </xsl:if>
                </xsl:for-each>
            </div>
        </div>
    </xsl:template>

    <!-- Special senderReceiver to extract the Rapido partner information -->
    <xsl:template name="RAPIDO-senderReceiver-returnslip">
        <table width="100%">
            <tr>
                <!-- Sender -->
                <td width="50%" align="left" valign="top" style="padding: 10mm 10mm 10mm 10mm;">
                    <xsl:for-each select="/notification_data/library">
                        <table>
                            <xsl:attribute name="style">
                                font-size: 80%;
                                <xsl:call-template name="listStyleCss" /> <!-- style.xsl -->
                            </xsl:attribute>
                            <xsl:if test="string-length(address/line1)!=0">
                                <tr><td><xsl:value-of select="address/line1"/></td></tr>
                            </xsl:if>
                            <xsl:if test="string-length(address/line2)!=0">
                                <tr><td><xsl:value-of select="address/line2"/></td></tr>
                            </xsl:if>
                            <xsl:if test="string-length(address/line3)!=0">
                                <tr><td><xsl:value-of select="address/line3"/></td></tr>
                            </xsl:if>
                            <xsl:if test="string-length(address/line4)!=0">
                                <tr><td><xsl:value-of select="address/line4"/></td></tr>
                            </xsl:if>
                            <xsl:if test="string-length(address/line5)!=0">
                                <tr><td><xsl:value-of select="address/line5"/></td></tr>
                            </xsl:if>
                            <tr><td><xsl:value-of select="address/postal_code"/>&#160;<xsl:value-of select="address/city"/></td></tr>
                            <xsl:if test="address/country != ''">
                                <tr><td><xsl:value-of select="address/country_display"/></td></tr>
                            </xsl:if>
                            <xsl:if test="string-length(phone/phone)!=0">
                                <tr><td><xsl:value-of select="phone/phone"/></td></tr>
                            </xsl:if>
                            <xsl:if test="string-length(email/email)!=0">
                                <tr><td><xsl:value-of select="email/email"/></td></tr>
                            </xsl:if>
                        </table>
                    </xsl:for-each>
                </td>
                <!-- Receiver -->
                <td width="50%" align="left" style="padding: 10mm 10mm 10mm 15mm; vertical-align: top;">
                    <table cellspacing="0" cellpadding="0" border="0">
                        <xsl:attribute name="style">
                            font-weight: 600;
                            <xsl:call-template name="listStyleCss" /> <!-- style.xsl -->
                        </xsl:attribute>
                        <xsl:for-each select="/notification_data/partner_address">
                            <xsl:if test="string-length(line1)!=0">
                                <tr><td><xsl:value-of select="line1"/></td></tr>
                            </xsl:if>
                            <xsl:if test="string-length(line2)!=0">
                                <tr><td><xsl:value-of select="line2"/></td></tr>
                            </xsl:if>
                            <xsl:if test="string-length(line3)!=0">
                                <tr><td><xsl:value-of select="line3"/></td></tr>
                            </xsl:if>
                            <xsl:if test="string-length(line4)!=0">
                                <tr><td><xsl:value-of select="line4"/></td></tr>
                            </xsl:if>
                            <xsl:if test="string-length(line5)!=0">
                                <tr><td><xsl:value-of select="line5"/></td></tr>
                            </xsl:if>
                            <xsl:if test="postal_code != '' or city != ''">
                                <tr><td>
                                    <xsl:if test="postal_code != ''">
                                        <xsl:value-of select="postal_code"/>
                                    </xsl:if>
                                    <xsl:if test="city != ''">
                                        <xsl:value-of select="city"/>
                                    </xsl:if>
                                </td></tr>
                            </xsl:if>
                            <xsl:if test="country_display != ''">
                                <tr><td><xsl:value-of select="country_display"/></td></tr>
                            </xsl:if>
                        </xsl:for-each>
                    </table>
                </td>
            </tr>
        </table>
    </xsl:template>

    <!-- Special senderReceiver to extract the Rapido partner information
        Delivery on the left side -->
    <xsl:template name="RAPIDO-senderReceiver-returnslip-reversed">
        <table width="100%">
            <tr>
                <!-- Receiver -->
                <td width="50%" align="left" style="padding: 10mm 5mm 10mm 20mm;vertical-align: top;">
                    <table cellspacing="0" cellpadding="0" border="0">
                        <xsl:attribute name="style">
                            font-weight: 600;
                            <xsl:call-template name="listStyleCss" /> <!-- style.xsl -->
                        </xsl:attribute>
                        <xsl:for-each select="/notification_data/partner_address">
                            <xsl:if test="string-length(line1)!=0">
                                <tr><td><xsl:value-of select="line1"/></td></tr>
                            </xsl:if>
                            <xsl:if test="string-length(line2)!=0">
                                <tr><td><xsl:value-of select="line2"/></td></tr>
                            </xsl:if>
                            <xsl:if test="string-length(line3)!=0">
                                <tr><td><xsl:value-of select="line3"/></td></tr>
                            </xsl:if>
                            <xsl:if test="string-length(line4)!=0">
                                <tr><td><xsl:value-of select="line4"/></td></tr>
                            </xsl:if>
                            <xsl:if test="string-length(line5)!=0">
                                <tr><td><xsl:value-of select="line5"/></td></tr>
                            </xsl:if>
                            <xsl:if test="postal_code != '' or city != ''">
                                <tr><td>
                                    <xsl:if test="postal_code != ''">
                                        <xsl:value-of select="postal_code"/>&#160;
                                    </xsl:if>
                                    <xsl:if test="city != ''">
                                        <xsl:value-of select="city"/>
                                    </xsl:if>
                                </td></tr>
                            </xsl:if>
                            <xsl:if test="country_display != ''">
                                <tr><td><xsl:value-of select="country_display"/></td></tr>
                            </xsl:if>
                        </xsl:for-each>
                    </table>
                </td>
                <!-- Sender -->
                <td width="50%" align="left" valign="top" style="padding: 10mm 10mm 10mm 15mm;vertical-align: top;">
                    <xsl:for-each select="/notification_data/library">
                        <table>
                            <xsl:attribute name="style">
                                font-size: 80%;
                                <xsl:call-template name="listStyleCss" /> <!-- style.xsl -->
                            </xsl:attribute>
                            <xsl:if test="string-length(address/line1)!=0">
                                <tr><td><xsl:value-of select="address/line1"/></td></tr>
                            </xsl:if>
                            <xsl:if test="string-length(address/line2)!=0">
                                <tr><td><xsl:value-of select="address/line2"/></td></tr>
                            </xsl:if>
                            <xsl:if test="string-length(address/line3)!=0">
                                <tr><td><xsl:value-of select="address/line3"/></td></tr>
                            </xsl:if>
                            <xsl:if test="string-length(address/line4)!=0">
                                <tr><td><xsl:value-of select="address/line4"/></td></tr>
                            </xsl:if>
                            <xsl:if test="string-length(address/line5)!=0">
                                <tr><td><xsl:value-of select="address/line5"/></td></tr>
                            </xsl:if>
                            <tr><td><xsl:value-of select="address/postal_code"/>&#160;<xsl:value-of select="address/city"/></td></tr>
                            <xsl:if test="address/country != ''">
                                <tr><td><xsl:value-of select="address/country_display"/></td></tr>
                            </xsl:if>
                            <xsl:if test="string-length(phone/phone)!=0">
                                <tr><td><xsl:value-of select="phone/phone"/></td></tr>
                            </xsl:if>
                            <xsl:if test="string-length(email/email)!=0">
                                <tr><td><xsl:value-of select="email/email"/></td></tr>
                            </xsl:if>
                        </table>
                    </xsl:for-each>
                </td>
            </tr>
        </table>
    </xsl:template>
    
	<xsl:template match="/">
		<html>
			<xsl:if test="notification_data/languages/string">
				<xsl:attribute name="lang">
					<xsl:value-of select="notification_data/languages/string"/>
				</xsl:attribute>
			</xsl:if>

			<head>
				<title>
					<xsl:value-of select="notification_data/general_data/subject"/>
				</title>

				<xsl:call-template name="generalStyle"/>
			</head>
			<body>
				<xsl:attribute name="style">
					<xsl:call-template name="bodyStyleCss"/>
					<!-- style.xsl -->
				</xsl:attribute>

				<div class="messageArea" style="clear: both;">
					<div class="messageBody">
                        <xsl:variable name="requestType">
                            <xsl:call-template name="request-type" />
                        </xsl:variable>
                        <xsl:choose>
                            <!-- ILL -->
                            <xsl:when test="$requestType = 'ILL'">
                                <xsl:call-template name="head-letterName-logo"/>
                                <xsl:call-template name="RAPIDO-senderReceiver-returnslip-reversed"/>
                            </xsl:when>
                            <!-- SLSP Courier, Local couriers, Personal Delivery -->
                            <xsl:otherwise>
                                <xsl:call-template name="head-letterName-only-return-slip"/>
                            </xsl:otherwise>
                        </xsl:choose>
                        
						<table role='presentation'  cellspacing="0" cellpadding="5" border="0">
                            <!-- SLSP: show return text for ILL -->
                            <xsl:if test="$requestType = 'ILL'">
                                <tr>
                                    <td>
                                        @@returned@@
                                    </td>
                                </tr>
                            </xsl:if>
                            <!-- SLSP: do not show from and request type for ILL -->
                            <xsl:if test="$requestType != 'ILL'">
                                <tr>
                                    <td style="padding-bottom: 10px">
                                        <strong><xsl:call-template name="SLSP-multilingual">
                                                <xsl:with-param name="en" select="'From'"/>
                                                <xsl:with-param name="fr">
                                                    <![CDATA[Depuis]]>
                                                </xsl:with-param>
                                                <xsl:with-param name="it" select="'Da'"/>
                                                <xsl:with-param name="de" select="'Von'"/>
                                            </xsl:call-template>: </strong>
                                        <!-- Sender library and IZ -->
                                        <xsl:value-of select="/notification_data/organization_unit/name"/> - <xsl:value-of select="/notification_data/library/name"/>
                                        <!-- Sender library in one line -->
                                        <!-- <xsl:for-each select="/notification_data/library">
                                                <xsl:if test="string-length(address/line1)!=0"><xsl:value-of select="address/line1"/></xsl:if>
                                                <xsl:if test="string-length(address/line2)!=0">, <xsl:value-of select="address/line2"/></xsl:if>
                                                <xsl:if test="string-length(address/line3)!=0">, <xsl:value-of select="address/line3"/></xsl:if>
                                                <xsl:if test="string-length(address/line4)!=0">, <xsl:value-of select="address/line4"/></xsl:if>
                                                <xsl:if test="string-length(address/line5)!=0">, <xsl:value-of select="address/line5"/></xsl:if>
                                                <span>, <xsl:value-of select="address/postal_code"/>&#160;<xsl:value-of select="address/city"/></span>
                                                <xsl:if test="address/country != ''">, <xsl:value-of select="address/country_display"/></xsl:if>
                                                <xsl:if test="string-length(phone/phone)!=0">
                                                    <xsl:value-of select="phone/phone"/>
                                                </xsl:if>
                                                <xsl:if test="string-length(email/email)!=0">
                                                    <xsl:value-of select="email/email"/>
                                                </xsl:if>
                                        </xsl:for-each>-->
                                        <br/>
                                        <xsl:call-template name="request-type"/>
                                    </td>
                                </tr>
                            </xsl:if>
                            <tr>
								<td style="padding-bottom: 10px">
                                    <strong>@@request_id@@:</strong><br />
                                    <img src="externalId.png" alt="externalId"/>
                                </td>
							</tr>
                            <tr>
								<td style="padding-bottom: 10px">
									<strong>@@required_return_date@@: </strong><xsl:value-of select="notification_data/request/due_date"/><br />
                                    <strong>@@arrival_date@@: </strong><xsl:value-of select="notification_data/request/item_arrival_date"/><br />
                                    <strong><xsl:call-template name="SLSP-multilingual">
											<xsl:with-param name="en" select="'Print date'"/>
											<xsl:with-param name="fr">
                                                <![CDATA[Date d'impression]]>
                                            </xsl:with-param>
											<xsl:with-param name="it" select="'Data stampa'"/>
											<xsl:with-param name="de" select="'Druckdatum'"/>
										</xsl:call-template>: </strong><xsl:value-of select="notification_data/general_data/current_date"/>&#160;<xsl:value-of select="substring(/notification_data/general_data/current_time, 1, 5)"/>
                                    <xsl:if test="notification_data/note_to_partner != ''">
                                        <br />
                                        <strong>@@note_to_partner@@: </strong>
                                        <xsl:value-of select="notification_data/note_to_partner"/>
                                    </xsl:if>
								</td>
							</tr>
							<xsl:if test="notification_data/request/return_info !=''">
								<tr>
									<td style="padding-bottom: 10px">
										<xsl:value-of select="notification_data/request/return_info"/>
									</td>
								</tr>
							</xsl:if>
                            <xsl:for-each select="notification_data/request/display">
                                <tr>
                                    <td style="padding-bottom: 10px">
                                        <strong><xsl:value-of select="title"/></strong>
                                        <xsl:if test="author != ''">
                                            <br />
                                            <xsl:value-of select="author"/>
                                        </xsl:if>
                                        <xsl:if test="place_of_publication != '' and publisher != '' and publication_date != ''">
                                            <br /><xsl:value-of select="place_of_publication"/>:&#160;<xsl:value-of select="publisher"/>,&#160;<xsl:value-of select="publication_date"/>
                                        </xsl:if>
                                    </td>
                                </tr>
                                
                                <xsl:if test="journal_title != ''">
                                    <tr>
                                        <td style="padding-bottom: 10px">
                                            <strong>@@journal_title@@: </strong>
                                            <xsl:value-of select="journal_title"/>
                                        </td>
                                    </tr>
                                </xsl:if>
                                <xsl:if test="volume != ''">
                                    <tr>
                                        <td style="padding-bottom: 10px">
                                            <strong>@@volume@@: </strong>
                                            <xsl:value-of select="volume"/>
                                        </td>
                                    </tr>
                                </xsl:if>
                                <!-- Hide issue field -->
                                <!-- <xsl:if test="issue != ''">
                                    <tr>
                                        <td>
                                            @@issue@@:
                                            <xsl:value-of select="issue"/>
                                        </td>
                                    </tr>
                                </xsl:if> -->
                            </xsl:for-each>
                            <xsl:if test="$requestType = 'ILL'">
                                <tr>
                                    <td>
                                        @@signature@@
                                    </td>
                                </tr>
                                <tr>
                                    <td>
                                        <xsl:value-of select="notification_data/library/name"/>
                                    </td>
                                </tr>
                            </xsl:if>                            
						</table>
					</div>
				</div>
				<!-- <xsl:call-template name="lastFooter"/> -->
				<!-- footer.xsl -->
			</body>
		</html>
	</xsl:template>
</xsl:stylesheet>
