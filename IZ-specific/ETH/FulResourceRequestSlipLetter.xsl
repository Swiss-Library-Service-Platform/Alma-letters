<?xml version="1.0" encoding="utf-8"?>
<xsl:stylesheet version="1.0"
xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
xmlns:str="http://exslt.org/strings">


<xsl:include href="header.xsl" />
<xsl:include href="senderReceiver.xsl" />
<xsl:include href="mailReason.xsl" />
<xsl:include href="footer.xsl" />
<xsl:include href="style.xsl" />
<xsl:include href="recordTitle.xsl" />
<xsl:template match="/">


	<html>
		<head>
		<xsl:call-template name="generalStyle" />
<style>

body {font-family: sans-serif; font-size:100% }
td {vertical-align:middle}

</style>

		</head>

			<body>  

				<xsl:call-template name="head" /> <!-- header.xsl -->

<!-- print user address / escherer 10.09.2020 -->
<br/>
	<xsl:choose>
		<xsl:when test="notification_data/user_for_printing">
			<table cellspacing="0" cellpadding="5" border="0" width="100%">
			<xsl:attribute name="style">
				<xsl:call-template name="listStyleCss" /> <!-- style.xsl -->
			</xsl:attribute>
			<tr><td width="55%"></td><td width="45%"><xsl:value-of select="notification_data/user_for_printing/name"/></td></tr>

<!-- hack - wenn Postbestellung (Lieferadresse: oder Büroadresse: wird delivery_addresse ausgegeben / escherer 12.01.2021 -->
		<xsl:choose>
		<xsl:when test="(substring(notification_data/request/delivery_address,1,11) != 'Startseite ') 
and (substring(notification_data/request/delivery_address,1,13) != 'Privatadresse')  
and (substring(notification_data/request/delivery_address,1,9) != 'Lieferung')  
and (substring(notification_data/request/delivery_address,1,4) != 'Heim') 
and (substring(notification_data/request/delivery_address,1,11) != 'Büroadresse')  
and (substring(notification_data/request/delivery_address,1,13) != 'Bürolieferung')
and (substring(notification_data/request/delivery_address,1,13) != 'Home Delivery') 
and (substring(notification_data/request/delivery_address,1,15) != 'Office Delivery') 
and (substring(notification_data/request/delivery_address,1,8) != 'Consegna') 
and (substring(notification_data/request/delivery_address,1,9) != 'Livraison') ">
			<tr><td></td><td><xsl:value-of select="notification_data/user_for_printing/address1"/></td></tr>
			<tr><td></td><td><xsl:value-of select="notification_data/user_for_printing/address2"/></td></tr>
			<xsl:if test="notification_data/user_for_printing/address3 !=''"><tr><td></td><td> <xsl:value-of select="notification_data/user_for_printing/address3"/></td></tr></xsl:if>
			<xsl:if test="notification_data/user_for_printing/address4 !=''"><tr><td></td><td> <xsl:value-of select="notification_data/user_for_printing/address4"/></td></tr></xsl:if>
			<xsl:if test="notification_data/user_for_printing/address5 !=''"><tr><td></td><td> <xsl:value-of select="notification_data/user_for_printing/address5"/></td></tr></xsl:if>
			<tr><td></td><td><xsl:value-of select="notification_data/user_for_printing/postal_code"/>&#160;<xsl:value-of select="notification_data/user_for_printing/city"/>
			</td></tr>
		</xsl:when>
		<xsl:otherwise>
			<xsl:if test="count(str:tokenize(notification_data/request/delivery_address,'&#10;'))>=4">
			<tr><td></td><td><xsl:value-of select="str:tokenize(notification_data/request/delivery_address,'&#10;')[2]"/></td></tr>													
			</xsl:if>
			<xsl:if test="count(str:tokenize(notification_data/request/delivery_address,'&#10;'))>5">
			<tr><td></td><td><xsl:value-of select="str:tokenize(notification_data/request/delivery_address,'&#10;')[3]"/></td></tr>													
			</xsl:if>
			<xsl:if test="count(str:tokenize(notification_data/request/delivery_address,'&#10;'))>6">
			<tr><td></td><td><xsl:value-of select="str:tokenize(notification_data/delivery_address,'&#10;')[4]"/></td></tr>													
			</xsl:if>
			<xsl:if test="count(str:tokenize(notification_data/request/delivery_address,'&#10;'))>7">
			<tr><td></td><td><xsl:value-of select="str:tokenize(notification_data/request/delivery_address,'&#10;')[5]"/></td></tr>													
			</xsl:if>
	        </xsl:otherwise>		
        	</xsl:choose>

		<xsl:variable name="letzte" select="count(str:tokenize(notification_data/request/delivery_address,'&#10;'))"/>
		<xsl:variable name="zweitletzte" select="count(str:tokenize(notification_data/request/delivery_address,'&#10;'))-1"/>
                <xsl:variable name="drittletzte" select="count(str:tokenize(notification_data/request/delivery_address,'&#10;'))-2"/>
		<xsl:choose>  
                     <xsl:when  test="string(number(str:tokenize(notification_data/request/delivery_address,'&#10;')[$letzte])) != 'NaN' ">
                       <tr><td></td><td><xsl:value-of select="str:tokenize(notification_data/request/delivery_address,'&#10;')[$letzte]"/>&#160;
			        <xsl:value-of select="str:tokenize(notification_data/request/delivery_address,'&#10;')[$zweitletzte]"/></td></tr>
                     </xsl:when>
                     <xsl:otherwise>
		       <tr><td></td><td><xsl:value-of select="str:tokenize(notification_data/request/delivery_address,'&#10;')[$zweitletzte]"/>&#160;
			        <xsl:value-of select="str:tokenize(notification_data/request/delivery_address,'&#10;')[$drittletzte]"/></td></tr>
                   </xsl:otherwise>	 
                </xsl:choose>

<!--
			<xsl:variable name="number_code" select="count(str:tokenize(notification_data/request/delivery_address,'&#10;'))-1"/>
			<xsl:variable name="number_city" select="count(str:tokenize(notification_data/request/delivery_address,'&#10;'))-2"/>
			<tr><td></td><td><xsl:value-of select="str:tokenize(notification_data/request/delivery_address,'&#10;')[$number_code]"/>&#160;
			<xsl:value-of select="str:tokenize(notification_data/request/delivery_address,'&#10;')[$number_city]"/></td></tr>
-->
		</table>
		 
		</xsl:when>
	</xsl:choose>
<br/><br/><br/>

<!-- brauchts nicht zweimal  escherer 1.9.2020
			<h1>
				<b>@@requested_for@@ :
							<xsl:value-of select="notification_data/user_for_printing/name"/>
				</b>
			</h1>    -->

			<div class="messageArea">
				<div class="messageBody">
					 <table width="100%" cellspacing="0" cellpadding="5" border="0">
						<xsl:if  test="notification_data/request/selected_inventory_type='ITEM'" >
						<tr>
							<td><b>@@note_item_specified_request@@.</b></td>
						</tr>
						</xsl:if>
						<xsl:if  test="notification_data/request/manual_description != ''" >
						<tr>
							<td><b>@@please_note@@: </b>@@manual_description_note@@ - <xsl:value-of select="notification_data/request/manual_description"/></td>
						</tr>
						</xsl:if>
<!-- test - escherer  22.9.2020   Variante png barcode  ausgeschaltet -->
<!-- 09.12.2020 - png barcodes wieder eingeschaltet -->
						<tr>
							<td><b>@@request_id@@: </b><img src="cid:request_id_barcode.png" alt="Request Barcode"/></td>
						</tr>
						<xsl:if  test="notification_data/request/selected_inventory_type='ITEM'" >
						<tr>
							<td><b>@@item_barcode@@: </b><img src="cid:item_id_barcode.png" alt="Item Barcode"/></td>
						</tr>
						</xsl:if>

						<xsl:if  test="notification_data/external_id != ''" >
							<tr>
								<td><b>@@external_id@@: </b><xsl:value-of select="notification_data/external_id"/></td>
							</tr>
						</xsl:if>
<!-- changed - escherer 1.9.2020 -->
						<xsl:if test="notification_data/user_for_printing/name">

						<tr>
							<td>
						        @@requested_for@@: 
							<b><xsl:value-of select="notification_data/user_for_printing/name"/></b> </td>
						</tr>
<!-- ***** added user group / escherer 22.9.2020 -->	
						<tr>
							<td>User Group:  <xsl:value-of select="notification_data/user_for_printing/user_group"/></td>
						</tr>
<!-- ***** added user identifier as barcode / escherer 22.9.2020 -->					       
                                                <xsl:for-each select="notification_data/user_for_printing/identifiers/code_value">
                                                                               
                                               <xsl:if test="code='02'">
                                                <tr>
							<td>
                                                        User Barcode NZ:<span style="font-family:CarolinaBar-B39-25G0; font-style:normal; font-size:18pt; line-height:36pt;"> *<xsl:value-of select="value"/>*</span></td>
						</tr>
                                                </xsl:if>                                                                          
                                                </xsl:for-each>
<!-- ***** end user identifier as barcode  -->                                                 
                                                </xsl:if>
						<tr>
<!-- recordTitle bold / escherer / 23.9.2020 -->
							<td><b><xsl:call-template name="recordTitle" /></b>
							</td>
						</tr>
<!-- 21.12.2020 - Publikations-Jahr ausgeben --> 
							<xsl:if test="notification_data/phys_item_display/edition != ''">
								<tr>
								<td><!-- @@edition@@: --> <xsl:value-of select="notification_data/phys_item_display/edition"/>
							    	<xsl:if test="notification_data/phys_item_display/publication_date!= ''">
								    - <xsl:value-of select="notification_data/phys_item_display/publication_date"/> 
								 </xsl:if></td>
								</tr>
							</xsl:if>
							 <xsl:if test="notification_data/phys_item_display/edition= ''">
								    <xsl:if test="notification_data/phys_item_display/publication_date!= ''">
                                                                     <tr><td>
								       <xsl:value-of select="notification_data/phys_item_display/publication_date"/> </td>
                                                                      </tr>
								     </xsl:if>                                                        
							 </xsl:if>
<!-- 21.12.2020 - escherer - format anzeigen -->
							<xsl:if test="notification_data/request/record_display_section/format != ''">
								<tr>
								<td><xsl:value-of select="notification_data/request/record_display_section/format"/></td>
								</tr>
							</xsl:if>
<!-- imprint nicht anzeigen / escherer / 23.9.2020
							<xsl:if test="notification_data/phys_item_display/imprint != ''">
								<tr>
								<td>@@imprint@@: <xsl:value-of select="notification_data/phys_item_display/imprint"/></td>
								</tr>
							</xsl:if>
      end imprint nicht anzeigen / escherer / 23.9.2020 -->
							<xsl:if test="notification_data/phys_item_display/isbn != ''">
								<tr>
								<td>@@isbn@@: <xsl:value-of select="notification_data/phys_item_display/isbn"/></td>
								</tr>
							</xsl:if>
							<xsl:if test="notification_data/phys_item_display/issn != ''">
								<tr>
								<td>@@issn@@: <xsl:value-of select="notification_data/phys_item_display/issn"/></td>
								</tr>
							</xsl:if>

<!-- creation_date einblenden - escherer 8.9.2020 -->
<tr>
<td align="right"><br/><b>Bestellzeit: </b> <xsl:value-of select="notification_data/request/create_date" />, <xsl:value-of select="notification_data/request/create_time" /></td>
</tr>

<!-- print special article/chapter info - escherer 16.09.2020 -->
                                                       <tr><td>
<!-- **** begin table formatting / escherer 21.09.2020 --> 
                                                          <table cellspacing="0" cellpadding="5" border="0"><tr><td colspan="2"><!-- leere Zeile --></td></tr>
							<xsl:if test="notification_data/request/chapter_article_title != ''">
								<tr>
								<td><b>Artikel/Kapitel: </b></td><td><xsl:value-of select="notification_data/request/chapter_article_title"/></td>
								</tr>
							</xsl:if>
							<xsl:if test="notification_data/request/chapter_article_author != ''">
								<tr>
								<td><b>Autor: </b></td><td><xsl:value-of select="notification_data/request/chapter_article_author"/></td>
								</tr>
							</xsl:if>
							<xsl:if test="notification_data/request/pages != ''">
								<tr>
								<td><b>Seiten:</b> </td><td><xsl:value-of select="notification_data/request/pages"/></td>
								</tr>
							</xsl:if>
							<xsl:if test="notification_data/request/full_chapter = 'true'">
								<tr>
								<td><b>Umfang:</b> </td><td> ganzes Kapitel</td>
								</tr>
							</xsl:if>				  
						<tr>         
<!-- changed, Label normal, value bold / escherer 10.9.2020 -->
							<td > @@location@@:</td><td>
<!-- **** inserted / escherer  22.9.2020 -->
<b><xsl:value-of select="notification_data/phys_item_display/owning_library_details/name"/></b> &#160;&#160;
<!-- **** end inserted / escherer  22.9.2020 -->	
<b><xsl:value-of select="notification_data/phys_item_display/location_name"/></b></td>
                                                 </tr>  
<!-- **** inserted / escherer  01.02.2020 -->
<xsl:if test="notification_data/phys_item_display/barcode != ''">           
<tr>                                                
	<td >Barcode:</td><td><xsl:value-of select="notification_data/phys_item_display/barcode"/></td>
</tr>
</xsl:if>
<!-- **** end inserted / escherer  01.02.2020 -->
                                                 <tr>   
							<xsl:if test="notification_data/phys_item_display/call_number != ''">                                                           
							<td >@@call_number@@:</td><td><b><xsl:value-of select="notification_data/phys_item_display/call_number"/></b></td>
							</xsl:if>
                                                 </tr> 
<!-- changed- escherer 22.9.2020  nur ausgeben wenn call_number nicht vorhanden ist -->
                                                 <tr>   
							<xsl:if test="notification_data/phys_item_display/accession_number != '' and notification_data/phys_item_display/call_number = '' ">                                                                   
								<td>@@accession_number@@:</td><td><b><xsl:value-of select="notification_data/phys_item_display/accession_number"/></b></td>
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
								<td >@@alt_call_number@@:  </td><td>
								 <b><xsl:for-each select="notification_data/phys_item_display/display_alt_call_numbers/string"> 
									<xsl:value-of select="."/>
								 &#160;
								 </xsl:for-each></b>
								</td>
							</tr>
							</xsl:if>
							<xsl:if  test="notification_data/request/selected_inventory_type='HOLDING'" >
							<tr>
								<td>@@alt_call_number@@: </td><td>
								<b><xsl:for-each select="notification_data/phys_item_display/display_alt_call_numbers/string">
									<xsl:value-of select="."/>
								&#160;
								 </xsl:for-each></b>
								</td>
							</tr>
							</xsl:if>
							<xsl:if  test="notification_data/request/selected_inventory_type='VIRTUAL_HOLDING'" >
							<tr>
								<td>@@alt_call_number@@:  </td><td>
								<b><xsl:for-each select="notification_data/phys_item_display/display_alt_call_numbers/string">
									<xsl:value-of select="."/>
								&#160;
								 </xsl:for-each></b>
								</td>
							</tr>
							</xsl:if>
						</xsl:if>
			
						<tr> 
							<td>@@move_to_library@@: </td><td><b><xsl:value-of select="notification_data/destination"/></b> 

<!-- 17.12.2020 - delivery_adress ausgeben - escherer - start --> 
<xsl:if test="notification_data/request/delivery_address != ''"><br/>
   <xsl:value-of select="substring-after (notification_data/request/delivery_address, ':')"/>
</xsl:if>
<!-- 17.12.2020 - delivery_adress ausgeben - escherer - end -->
                                                      </td>
						</tr>

						<tr>
							<td>@@request_type@@:</td><td><b><xsl:value-of select="notification_data/request_type"/></b></td>
						</tr>

						<xsl:if test="notification_data/request/system_notes != ''">
							<tr>
							<td><b>@@system_notes@@:</b></td><td><xsl:value-of select="notification_data/request/system_notes"/></td>
						</tr>
						</xsl:if>

						<xsl:if test="notification_data/request/note != ''">
							<tr>
							<td><b>@@request_note@@:</b></td><td> <xsl:value-of select="notification_data/request/note"/></td>
						</tr>
						</xsl:if>
<!-- **** end table formatting / escherer 21.09.2020 --> 
                                                 </table>
                                                </td ></tr>
<!-- **** --> 
					</table>

<!-- Anzeige available items - escherer / 22.12.2020 -->
<xsl:if test="notification_data/request/selected_inventory_type!='ITEM'">
                                                <xsl:if test="notification_data/phys_item_display/available_items/available_item/barcode!='ITEM'">
							<table cellpadding="5" class="listing">
								<xsl:attribute name="style">
									<xsl:call-template name="mainTableStyleCss"/>									 
								</xsl:attribute>
								<tr>
									<td colspan="6">
										<b>Available items:</b>
									</td>
								</tr>
								<tr>
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
</xsl:if>
<!-- Anzeige available items  -->


				</div>
			</div>



 
	<xsl:call-template name="lastFooter" />    <!-- footer.xsl -->
 




</body>
</html>


	</xsl:template>
</xsl:stylesheet>