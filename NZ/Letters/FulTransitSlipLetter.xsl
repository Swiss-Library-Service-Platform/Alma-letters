<?xml version="1.0" encoding="utf-8"?>
<!-- SLSP WG: Letters version 09/2021;
        10/2021 fixed printUserAnonymize
        11/2021 smaller margin to fix issue on slip printers (SUPPORT-13074)
        11/2021 added Barcode edu-ID
        05/2022 synced header adaptation
        08/2024 Added space between request barcode and item barcode -->
<!-- Dependance:
        recordTitle - SLSP-multilingual
        style - generalStyle, bodyStyleCss
        -->
<xsl:stylesheet version="1.0"
xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
xmlns:str="http://exslt.org/strings">
    <xsl:include href="header.xsl" />
    <xsl:include href="senderReceiver.xsl" />
    <xsl:include href="mailReason.xsl" />
    <xsl:include href="footer.xsl" />
    <xsl:include href="style.xsl" />
    <xsl:include href="recordTitle.xsl" />

    <!-- insert transit header without logo-->
    <xsl:template name="head-letterName-only">
        <p style="background-color:#e9e9e9; width:100%; height:30px; line-height: 30px; margin: 0 15 5 0;" id="head-letter-name">
            <span style="font-size: 170%; vertical-align: middle; text-shadow:1px 1px 1px #fff;"><xsl:value-of select="/notification_data/general_data/subject"/></span>
        </p>
    </xsl:template>

    <!--Template to extract the delivery type from delivery_address node 
        If there is a delivery type in delivery address, take that information and output it
        If there is a delivery type, it is on the first row followed by ':' and a newline -->
    <xsl:template name="deliveryType">
        <xsl:variable name="deliveryAddress" select="str:tokenize(/notification_data/request/delivery_address, ':')"/>
        <xsl:if test="count($deliveryAddress) > 1">
            &#160;-&#160;<xsl:value-of select="$deliveryAddress[1]" />
        </xsl:if>
    </xsl:template>

    <!--Template to apply anonymization based on destination IZ and request type
        Observed behaviour of Transit letters and destination ID field
        - generated within IZ: sometimes the /notification_data/request/work_flow_entity/destination_institution_code is not present in XML
        - generated outside IZ: the /notification_data/request/work_flow_entity/calculated_destination_id shows id ending with suffix of the origin IZ and not destination
        Logic:
        - if the /notification_data/request/work_flow_entity/destination_institution_code is empty
        - then use the last 4 digits from /notification_data/request/work_flow_entity/calculated_destination_id to identify the destination IZ
        - otherwise use the /notification_data/request/work_flow_entity/destination_institution_code
        -->
    <xsl:template name="printUserAnonymize">
        <!-- setting up the variable destination_id with destination IZ ID; variable format can be either "5518" or "41SLSP_FNW" -->
        <xsl:variable name="destination_id">
            <xsl:choose>
                <xsl:when test="/notification_data/request/work_flow_entity/destination_institution_code = ''">
                    <xsl:variable name="destination_id_raw" select="/notification_data/request/work_flow_entity/calculated_destination_id"/>
                    <xsl:value-of select="substring($destination_id_raw, string-length($destination_id_raw)-3)"/>
                </xsl:when>
                <xsl:otherwise>
                    <xsl:value-of select="/notification_data/request/work_flow_entity/destination_institution_code"/>
                </xsl:otherwise>
            </xsl:choose>
        </xsl:variable>

        <!-- Need to test for both id types since it can come up from different fields based on Alma behaviour -->
        <xsl:choose>
            <xsl:when test="($destination_id = '5518' or $destination_id = '41SLSP_FNW') and (/notification_data/request/request_type = 'PATRON_PHYSICAL')"></xsl:when><!-- anonymize FHNW IZ -->
            <!-- <xsl:when test="($destination_id = '5512' or $destination_id = '41SLSP_ZHK') and (/notification_data/request/request_type = 'PATRON_PHYSICAL')"></xsl:when> --><!-- anonymize ZHdK IZ -->
            <xsl:otherwise><!-- no anonymization -->
                @@email@@: <xsl:value-of select="/notification_data/user_for_printing/email" /><br />
                @@tel@@: <xsl:value-of select="/notification_data/user_for_printing/phone" /><br />
                <xsl:if test="/notification_data/request/lastInterestDate != ''">
                    @@expiration_date@@: <xsl:value-of select="/notification_data/request/lastInterestDate" /><br />
                </xsl:if>
                <xsl:for-each select="/notification_data/user_for_printing/identifiers/code_value">
                    <xsl:if test="code = 01">
                        Barcode edu-ID: <xsl:value-of select="value" /><br />
                    </xsl:if>
                    <xsl:if test="code = 02">
                        Barcode NZ: <xsl:value-of select="value" /><br />
                        <!-- <span style="font-family:'CarolinaBar-B39-2.5-22x158x720'; font-size:24pt">*<xsl:value-of select="value" />*</span> -->
                    </xsl:if>
                    <xsl:if test="code = 'Primary Identifier'">
                        Primary identifier: <xsl:value-of select="value" /><br />
                    </xsl:if>
                </xsl:for-each>
            </xsl:otherwise>
        </xsl:choose>
    </xsl:template>

    <xsl:template match="/">
        <html>
            <head>
                <xsl:call-template name="generalStyle" />
            </head>
            <body>
                <xsl:attribute name="style">
                    <xsl:call-template name="bodyStyleCss" />
                    <!-- style.xsl -->
                </xsl:attribute>
                <!-- <xsl:call-template name="head" />  -->
                <!-- header.xsl -->
                <div class="messageArea" style="padding: 5">
                    <div class="messageBody">
                        <p style="font-size: 160%; font-weight: bold">&#x21e8;<xsl:value-of select="notification_data/request/calculated_destination_name" /></p>
                        <xsl:call-template name="head-letterName-only" />
                        <table cellspacing="0" cellpadding="0" border="0">
                            <tr>
                                <td style="padding-bottom: 10px">            
                                    @@from@@: <xsl:value-of select="notification_data/request/assigned_unit_name" /><br />
                                    <!-- If we know exactly the type of transit then print it -->
                                    <xsl:choose>
                                        <xsl:when test="notification_data/request/request_type = 'PATRON_PHYSICAL'">
                                            <xsl:value-of select="notification_data/request/request_type" /><xsl:call-template name="deliveryType" /><br />
                                        </xsl:when>
                                        <xsl:when test="/notification_data/request/request_type = 'PHYSICAL_TO_DIGITIZATION'">
                                            <xsl:value-of select="notification_data/request/request_type" /><br />
                                        </xsl:when>
                                        <xsl:when test="/notification_data/request/request_type = 'TRANSIT_FOR_RESHELVING'">
                                            <xsl:value-of select="notification_data/request/request_type" /><br />
                                        </xsl:when>
                                        <xsl:when test="/notification_data/request/request_type = 'BOOKING'">
                                            <xsl:value-of select="notification_data/request/request_type" /><br />
                                        </xsl:when>
                                    </xsl:choose>
                                </td>
                            </tr>
                            <tr>
                                <td style="padding-bottom: 25px">
                                    @@request_id@@<br />
                                    <img src="cid:request_id_barcode.png" alt="Request Barcode" />
                                </td>
                            </tr>
                            <tr>
                                <td style="padding-bottom: 10px">
                                    @@item_barcode@@<br />
                                    <img src="cid:item_id_barcode.png" alt="Item Barcode" /><br />
                                    <xsl:if test="notification_data/request/system_notes != ''">
                                        @@system_notes@@: <xsl:value-of select="notification_data/request/system_notes" /><br />
                                    </xsl:if>
                                    <xsl:if test="notification_data/request/note != ''">
                                        @@request_note@@: <xsl:value-of select="notification_data/request/note" /><br />
                                    </xsl:if>
                                    @@request_date@@: <xsl:value-of select="notification_data/request/create_date" />, <xsl:value-of select="substring(/notification_data/request/create_time,1,5)"/><br />
                                    @@print_date@@: <xsl:value-of select="notification_data/general_data/current_date"/>
                                </td>
                            </tr>
                            <tr>
                                <td style="padding-top: 15px; padding-bottom: 10px">
                                    <span style="font-size: 120%; font-weight: bold">
                                        <xsl:value-of select="substring(notification_data/phys_item_display/title, 0, 100)" disable-output-escaping="yes"/>
                                        <xsl:if test="string-length(notification_data/phys_item_display/title) > 100">...</xsl:if></span><br />
                                    <xsl:if test="notification_data/phys_item_display/display_alt_call_numbers != '' or notification_data/phys_item_display/call_number != ''">
                                        @@call_number@@:
                                        <!-- Display item call number, if not present then display the title call number -->
                                        <span style="font-size: 120%; font-weight: bold">
                                            <xsl:choose>
                                                <xsl:when test="notification_data/phys_item_display/display_alt_call_numbers != ''">
                                                    <xsl:value-of select="notification_data/phys_item_display/display_alt_call_numbers"/>
                                                </xsl:when>
                                                <xsl:otherwise>
                                                    <xsl:value-of select="notification_data/phys_item_display/call_number"/>
                                                </xsl:otherwise>
                                            </xsl:choose>
                                        </span>
                                        <br />
                                    </xsl:if>
                                    @@material_type@@: <xsl:value-of select="notification_data/request/material_type_display" /> <br />
                                    @@owning_library@@: <xsl:value-of select="notification_data/phys_item_display/owning_library_name" /> <br />
                                    <!-- @@item_barcode@@: <xsl:value-of select="notification_data/phys_item_display/barcode" /><br /> -->
                                    <xsl:if test="/notification_data/request/request_type = 'PHYSICAL_TO_DIGITIZATION'">
                                        <xsl:call-template name="SLSP-multilingual">
											<xsl:with-param name="en" select="'Author'"/>
											<xsl:with-param name="fr" select="'Auteur'"/>
											<xsl:with-param name="it" select="'Autore'"/>
											<xsl:with-param name="de" select="'Autor'"/>
										</xsl:call-template>: <xsl:value-of select="notification_data/request/chapter_article_author" /><br />
                                        <xsl:call-template name="SLSP-multilingual">
											<xsl:with-param name="en" select="'Chapter'"/>
											<xsl:with-param name="fr" select="'Chapitre'"/>
											<xsl:with-param name="it" select="'Capitolo'"/>
											<xsl:with-param name="de" select="'Kapitel'"/>
										</xsl:call-template>: <xsl:value-of select="notification_data/request/chapter_article_title" /><br />
                                        <xsl:call-template name="SLSP-multilingual">
											<xsl:with-param name="en" select="'Pages'"/>
											<xsl:with-param name="fr" select="'Pages'"/>
											<xsl:with-param name="it" select="'Pagine'"/>
											<xsl:with-param name="de" select="'Seiten'"/>
										</xsl:call-template>: <xsl:value-of select="notification_data/request/pages" />
                                    </xsl:if>
                                </td>
                            </tr>
                            <xsl:if test="notification_data/user_for_printing/name != ''">
                                <tr>
                                    <td style="padding-top: 15px; padding-bottom: 10px">
                                        <span style="font-size: 120%;">@@requested_for@@: <strong><xsl:value-of select="notification_data/user_for_printing/name" /></strong></span><br />
                                    </td>
                                </tr>
                                <tr>
                                    <td style="padding-bottom: 10px">
                                        <xsl:call-template name="printUserAnonymize"/>
                                    </td>
                                </tr>
                            </xsl:if> 
                        </table>
                    </div>
                </div>
            </body>
        </html>
    </xsl:template>
</xsl:stylesheet>