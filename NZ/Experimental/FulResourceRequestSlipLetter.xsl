<?xml version="1.0" encoding="utf-8"?>
<xsl:stylesheet version="1.0"
xmlns:xsl="http://www.w3.org/1999/XSL/Transform">


<xsl:include href="header.xsl" />
<xsl:include href="senderReceiver.xsl" />
<xsl:include href="mailReason.xsl" />
<xsl:include href="footer.xsl" />
<xsl:include href="style.xsl" />
<xsl:include href="recordTitle.xsl" />
<xsl:template match="/">
	<html>
			<xsl:if test="notification_data/languages/string">
				<xsl:attribute name="lang">
					<xsl:value-of select="notification_data/languages/string"/>
				</xsl:attribute>
			</xsl:if>

		<head>
    		<xsl:call-template name="generalStyle" />
		</head>

			<body>
			<h1>
				<strong>@@requested_for@@ :
							<xsl:value-of select="notification_data/user_for_printing/name"/>
				</strong>
			</h1>


				<xsl:call-template name="head" /> <!-- header.xsl -->



			<div class="messageArea">
				<div class="messageBody">
					 <table role='presentation'  cellspacing="0" cellpadding="5" border="0">
						<xsl:if  test="notification_data/request/selected_inventory_type='ITEM'" >
						<tr>
							<td><strong>@@note_item_specified_request@@.</strong></td>
						</tr>
						</xsl:if>
						<xsl:if  test="notification_data/request/manual_description != ''" >
						<tr>
							<td><strong>@@please_note@@: </strong>@@manual_description_note@@ - <xsl:value-of select="notification_data/request/manual_description"/></td>
						</tr>
						</xsl:if>
						<tr>
							<td><strong>@@request_id@@: </strong><img src="cid:request_id_barcode.png" alt="Request Barcode"/></td>
						</tr>
						<!-- <xsl:if  test="notification_data/request/selected_inventory_type='ITEM'" >
						<tr>
							<td><strong>@@item_barcode@@: </strong><img src="cid:item_id_barcode.png" alt="Item Barcode"/></td>
						</tr>
						</xsl:if> -->

                        <!-- Ex Libris solution for printing barcode using fonts -->
                        <xsl:if test="notification_data/request/selected_inventory_type='ITEM'" >
                            <tr>
                                <td><b>@@item_barcode@@:&#160; </b><span style="font-family:'CarolinaBar-B39-2.5-22x158x720'; font-size:32pt">*<xsl:value-of select="notification_data/phys_item_display/available_items/available_item/barcode"/>*</span></td>
                            </tr>
                        </xsl:if>
						<xsl:if  test="notification_data/external_id != ''" >
							<tr>
								<td><strong>@@external_id@@: </strong><xsl:value-of select="notification_data/external_id"/></td>
							</tr>
						</xsl:if>

						<xsl:if test="notification_data/user_for_printing/name">

						<tr>
							<td>
						<strong>@@requested_for@@: </strong>
							<xsl:value-of select="notification_data/user_for_printing/name"/></td>
						</tr>

						</xsl:if>

						<tr>
							<td><xsl:call-template name="recordTitle" />
							</td>
						</tr>

                        <xsl:if test="notification_data/phys_item_display/edition != ''">
                            <tr>
                                <td>@@edition@@: <xsl:value-of select="notification_data/phys_item_display/edition"/></td>
                            </tr>
                        </xsl:if>

							<!--<xsl:if test="notification_data/phys_item_display/isbn != ''">
								<tr>
								<td>@@isbn@@: <xsl:value-of select="notification_data/phys_item_display/isbn"/></td>
								</tr>
							</xsl:if>
							<xsl:if test="notification_data/phys_item_display/issn != ''">
								<tr>
								<td>@@issn@@: <xsl:value-of select="notification_data/phys_item_display/issn"/></td>
								</tr>
							</xsl:if>
							
							<xsl:if test="notification_data/phys_item_display/imprint != ''">
								<tr>
								<td>@@imprint@@: <xsl:value-of select="notification_data/phys_item_display/imprint"/></td>
								</tr>
							</xsl:if>-->
                        <!-- creation_date einblenden - escherer 8.9.2020 -->
                        <tr><!-- translate -->
                            <td align="right"><br/><b>Bestellzeit: </b> <xsl:value-of select="notification_data/request/create_date" />, <xsl:value-of select="notification_data/request/create_time" /></td>
                        </tr>
                        <!-- print special article/chapter info - escherer 16.09.2020 -->
                        <tr>
                            <td>
                                <!-- **** begin table formatting / escherer 21.09.2020 --> 
                                <table cellspacing="0" cellpadding="5" border="0">
                                    <tr>
                                        <td colspan="2">Item information</td> <!-- translate -->
                                    </tr>
                                <xsl:if test="notification_data/request/chapter_article_title != ''">
                                    <tr><!-- translate -->
                                        <td><b>Artikel/Kapitel: </b></td><td><xsl:value-of select="notification_data/request/chapter_article_title"/></td>
                                    </tr>
                                </xsl:if>
                                <xsl:if test="notification_data/request/chapter_article_author != ''">
                                    <tr><!-- translate -->
                                        <td><b>Autor: </b></td><td><xsl:value-of select="notification_data/request/chapter_article_author"/></td>
                                    </tr>
                                </xsl:if>
                                <xsl:if test="notification_data/request/pages != ''">
                                    <tr><!-- translate -->
                                        <td><b>Seiten:</b> </td><td><xsl:value-of select="notification_data/request/pages"/></td>
                                    </tr>
                                </xsl:if>
                                <xsl:if test="notification_data/request/full_chapter = 'true'">
                                    <tr><!-- translate -->
                                        <td><b>Umfang:</b> </td><td> ganzes Kapitel</td>
                                    </tr>
                                </xsl:if>				  
						            <tr>         
                                    <!-- changed, Label normal, value bold / escherer 10.9.2020 -->
                                        <td> @@location@@:</td>
                                        <td>
                                            <!-- **** inserted / escherer  22.9.2020 -->
                                            <b><xsl:value-of select="notification_data/phys_item_display/owning_library_details/name"/></b> &#160;&#160;
                                            <!-- **** end inserted / escherer  22.9.2020 -->	
                                            <b><xsl:value-of select="notification_data/phys_item_display/location_name"/></b>
                                        </td>
                                    </tr>  
                                    <!-- **** inserted / escherer  01.02.2020 -->
                                <xsl:if test="notification_data/phys_item_display/barcode != ''">           
                                    <tr><!-- translate -->                                                
                                        <td >Barcode:</td><td><xsl:value-of select="notification_data/phys_item_display/barcode"/></td>
                                    </tr>
                                </xsl:if>
                                    <!-- **** end inserted / escherer  01.02.2020 -->
                                    <xsl:if test="notification_data/phys_item_display/barcode != ''">           
                                        <tr><!-- translate -->                                                
                                            <td>Request ID: </td><td><xsl:value-of select="notification_data/request_id"/></td>
                                        </tr>
                                    </xsl:if>
                                    <tr>   
                                        <xsl:if test="notification_data/phys_item_display/call_number != ''">                                                           
                                            <td >@@call_number@@:</td>
                                            <td><b><xsl:value-of select="notification_data/phys_item_display/call_number"/></b></td>
                                        </xsl:if>
                                    </tr> 
                                    <!-- changed- escherer 22.9.2020  nur ausgeben wenn call_number nicht vorhanden ist -->
                                    <tr>   
                                        <xsl:if test="notification_data/phys_item_display/accession_number != '' and notification_data/phys_item_display/call_number = '' ">                                                                   
                                            <td>@@accession_number@@:</td>
                                            <td><b><xsl:value-of select="notification_data/phys_item_display/accession_number"/></b></td>
                                        </xsl:if>
                                    </tr>      

                            <xsl:if  test="notification_data/phys_item_display/shelving_location/string" >
                                <xsl:if  test="notification_data/request/selected_inventory_type='ITEM'" >
                                    <tr> 
                                        <td>@@shelving_location_for_item@@: </td><td>
                                        <b><xsl:for-each select="notification_data/phys_item_display/shelving_location/string">
                                            <xsl:value-of select="."/>
                                        &#160;
                                        </xsl:for-each></b>
                                        </td>
                                    </tr>
                                </xsl:if>
                                <xsl:if  test="notification_data/request/selected_inventory_type='HOLDING'" >
                                    <tr>
                                        <td>@@shelving_locations_for_holding@@: </td><td>
                                        <b><xsl:for-each select="notification_data/phys_item_display/shelving_location/string">
                                            <xsl:value-of select="."/>
                                        &#160;
                                        </xsl:for-each></b>
                                        </td>
                                    </tr>
                                </xsl:if>
                                <xsl:if  test="notification_data/request/selected_inventory_type='VIRTUAL_HOLDING'" >
                                    <tr>
                                        <td>@@shelving_locations_for_holding@@: </td><td>
                                        <b><xsl:for-each select="notification_data/phys_item_display/shelving_location/string">
                                            <xsl:value-of select="."/>
                                        &#160;
                                        </xsl:for-each></b>
                                        </td>
                                    </tr>
                                </xsl:if>
                            </xsl:if>
                            <xsl:if  test="notification_data/phys_item_display/display_alt_call_numbers/string" >
                                <xsl:if  test="notification_data/request/selected_inventory_type='ITEM'" >
                                    <tr>  
                                        <td >@@alt_call_number@@:  </td>
                                        <td>
                                            <b><xsl:for-each select="notification_data/phys_item_display/display_alt_call_numbers/string"> 
                                                <xsl:value-of select="."/>&#160;
                                                </xsl:for-each></b>
                                        </td>
                                    </tr>
                                </xsl:if>
                                <xsl:if  test="notification_data/request/selected_inventory_type='HOLDING'" >
                                    <tr>
                                        <td>@@alt_call_number@@: </td>
                                        <td>
                                            <b><xsl:for-each select="notification_data/phys_item_display/display_alt_call_numbers/string">
                                                <xsl:value-of select="."/>
                                            &#160;
                                            </xsl:for-each></b>
                                        </td>
                                    </tr>
                                </xsl:if>
                                <xsl:if  test="notification_data/request/selected_inventory_type='VIRTUAL_HOLDING'" >
                                    <tr>
                                        <td>@@alt_call_number@@:  </td>
                                        <td>
                                            <b><xsl:for-each select="notification_data/phys_item_display/display_alt_call_numbers/string">
                                                <xsl:value-of select="."/>
                                            &#160;
                                            </xsl:for-each></b>
                                        </td>
                                    </tr>
                                </xsl:if>
                            </xsl:if>
			
                                    <tr> 
                                        <td>@@move_to_library@@: </td>
                                        <td>
                                            <b><xsl:value-of select="notification_data/destination"/></b> 

                                            <!-- 17.12.2020 - delivery_adress ausgeben - escherer - start --> 
                                            <xsl:if test="notification_data/request/delivery_address != ''"><br/>
                                                <xsl:value-of select="substring-after (notification_data/request/delivery_address, ':')"/>
                                            </xsl:if>
                                            <!-- 17.12.2020 - delivery_adress ausgeben - escherer - end -->
                                        </td>
                                    </tr>

                                    <tr><!-- translate the value -->
                                        <td>@@request_type@@:</td>
                                        <td><b><xsl:value-of select="notification_data/request_type"/></b></td>
                                    </tr>

                                    <xsl:if test="notification_data/request/system_notes != ''">
                                        <tr>
                                            <td><b>@@system_notes@@:</b></td>
                                            <td><xsl:value-of select="notification_data/request/system_notes"/></td>
                                        </tr>
                                    </xsl:if>

                                    <xsl:if test="notification_data/request/note != ''">
                                        <tr>
                                            <td><b>@@request_note@@:</b></td>
                                            <td> <xsl:value-of select="notification_data/request/note"/></td>
                                        </tr>
                                    </xsl:if>
                <!-- **** end table formatting / escherer 21.09.2020 --> 
                                </table>
                            </td>
                        </tr>
                <!-- **** --> 
					</table>
                    <!-- Available items -->
                <xsl:if test="notification_data/request/selected_inventory_type != 'ITEM'">
                    <table cellpadding="5" class="listing">
                        <xsl:attribute name="style">
                            <xsl:call-template name="mainTableStyleCss"/>									 
                        </xsl:attribute>
                        <tr>
                            <td colspan="6">
                                <b>Available items:</b>
                            </td>
                        </tr>
                        <tr><!-- translate -->
                            <th>Barcode</th>
                            <th>Call number</th>
                            <th>Library</th>
                            <th>Location</th>
                            <th>Item policy</th>
                            <th>Public note</th>
                        </tr>
                    <xsl:for-each select="notification_data/phys_item_display/available_items/available_item">
                        <tr>
                            <td>
                                <xsl:value-of select="barcode"/>
                            </td>
                            <td>
                                <xsl:value-of select="call_number"/>
                            </td>
                            <td>
                                <xsl:value-of select="library_name"/>
                            </td>
                            <td>
                                <xsl:value-of select="location_name"/>
                            </td>
                            <td>
                                <xsl:value-of select="item_policy"/>
                            </td>
                            <td>
                                <xsl:value-of select="public_note"/>
                            </td>
                        </tr>
                    </xsl:for-each>
                    </table>
                </xsl:if>
<!-- Anzeige available items  -->
				</div>
			</div>
            <table>
                <tr>
                    <td>
                        <xsl:value-of select="notification_data/organization_unit/name" />
                    </td>
                </tr>
                <tr>
                    <td><br/><i>powered by SLSP</i></td>
                </tr>
            </table>
	<!--<xsl:call-template name="lastFooter" /> --><!-- footer.xsl -->
        </body>
    </html>

</xsl:template>
</xsl:stylesheet>