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
				<title>
					<xsl:value-of select="notification_data/general_data/subject"/>
				</title>

				<xsl:call-template name="generalStyle" />
			</head>
			<body>
				<xsl:attribute name="style">
					<xsl:call-template name="bodyStyleCss" />
					<!-- style.xsl -->
				</xsl:attribute>
				<xsl:call-template name="head" />
				<!-- header.xsl -->

				<table role='presentation'  cellspacing="0" cellpadding="5" border="0">
					<xsl:choose>
						<xsl:when test="notification_data/query_type = 'Type_1_query_name'">
							<tr>
								<td>
									<h3>@@Type_1_header@@</h3>
								</td>
							</tr>
						</xsl:when>
						<xsl:when test="notification_data/query_type = 'Type_2_query_name'">
							<tr>
								<td>
									<h3>@@Type_2_header@@</h3>
								</td>
							</tr>
						</xsl:when>
						<xsl:when test="notification_data/query_type = 'Type_3_query_name'">
							<tr>
								<td>
									<h3>@@Type_3_header@@</h3>
								</td>
							</tr>
						</xsl:when>
						<xsl:when test="notification_data/query_type = 'Type_4_query_name'">
							<tr>
								<td>
									<h3>@@Type_4_header@@</h3>
								</td>
							</tr>
						</xsl:when>
						<xsl:when test="notification_data/query_type = 'Type_5_query_name'">
							<tr>
								<td>
									<h3>@@Type_5_header@@</h3>
								</td>
							</tr>
						</xsl:when>
						<xsl:otherwise>
							<tr>
								<td>
									<h3>@@Type_1_header@@</h3>
								</td>
							</tr>
						</xsl:otherwise>
					</xsl:choose>
				</table>

				<div class="messageArea">
					<div class="messageBody">
						<table role='presentation'  cellspacing="0" cellpadding="5" border="0">

							<tr>
								<td>
									@@requested@@ <xsl:value-of select="notification_data/request/create_date"/> @@Type_1_subject@@:

								</td>

							</tr>
						</table>
						<br />
						<table role='presentation'  cellspacing="0" cellpadding="5" border="0">

							<xsl:attribute name="style">
								<xsl:call-template name="listStyleCss" />
								<!-- style.xsl -->
							</xsl:attribute>
<!-- Notice bib -->

								<tr>
									<td>
							<xsl:if test="notification_data/request/display/title !=''">
										<xsl:value-of select="notification_data/request/display/title" />
							
							</xsl:if>
							<xsl:if test="notification_data/request/display/edition !=''">
										, <xsl:value-of select="notification_data/request/display/edition" />
								
							</xsl:if>
							<xsl:if test="notification_data/request/display/author !=''">
										. <xsl:value-of select="notification_data/request/display/author" />
									
							</xsl:if>
							<xsl:if test="notification_data/request/display/journal_title !=''">
										. <xsl:value-of select="notification_data/request/display/journal_title" />
							
							</xsl:if>
							<xsl:if test="notification_data/request/display/volume !=''">
										, <xsl:value-of select="notification_data/request/display/volume" />
										
							</xsl:if>
							<xsl:if test="notification_data/request/display/issue !=''">
										, <xsl:value-of select="notification_data/request/display/issue" />
										
							</xsl:if>
. 
							<xsl:if
								test="notification_data/request/display/place_of_publication !=''">
										<xsl:value-of select="notification_data/request/display/place_of_publication" />
									
							</xsl:if>
							<xsl:if test="notification_data/request/display/publisher !=''">
										: <xsl:value-of select="notification_data/request/display/publisher" />
										
							</xsl:if>
							<xsl:if test="notification_data/request/display/publication_date !=''">
										, <xsl:value-of select="notification_data/request/display/publication_date" />
										
							</xsl:if>
                                                       <xsl:if test="notification_data/request/display/isbn !=''">
										. ISBN <xsl:value-of select="notification_data/request/display/isbn" />
										
							</xsl:if>
							<xsl:if test="notification_data/request/display/issn !=''">
										. ISSN <xsl:value-of select="notification_data/request/display/issn" />
										
							</xsl:if>
									</td>
								</tr>



<!-- 			<xsl:if test="notification_data/request/display/material_type !=''">
								<tr>
									<td>
										<strong> @@format@@:  </strong>
										<xsl:value-of
											select="notification_data/request/display/material_type" />
				
									</td>
								</tr>
							</xsl:if>
							<xsl:if test="notification_data/request/display/title !=''">
								<tr>
									<td>
										<strong> @@title@@: </strong>
										<xsl:value-of select="notification_data/request/display/title" />
								
									</td>
								</tr>
							</xsl:if>
							<xsl:if test="notification_data/request/display/journal_title !=''">
								<tr>
									<td>
										<strong> @@journal_title@@: </strong>
										<xsl:value-of
											select="notification_data/request/display/journal_title" />
									
									</td>
								</tr>
							</xsl:if>
							<xsl:if test="notification_data/request/display/author !=''">
								<tr>
									<td>
										<strong> @@author@@: </strong>
										<xsl:value-of select="notification_data/request/display/author" />
								
									</td>
								</tr>
							</xsl:if>
							<xsl:if test="notification_data/request/display/autho_initials !=''">
								<tr>
									<td>
										<strong> @@author_initials@@: </strong>
										<xsl:value-of
											select="notification_data/request/display/autho_initials" />
										
									</td>
								</tr>
							</xsl:if>
							<xsl:if test="notification_data/request/display/publisher !=''">
								<tr>
									<td>
										<strong> @@publisher@@: </strong>
										<xsl:value-of select="notification_data/request/display/publisher" />
									
									</td>
								</tr>
							</xsl:if>
							<xsl:if
								test="notification_data/request/display/place_of_publication !=''">
								<tr>
									<td>
										<strong> @@place_of_publication@@: </strong>
										<xsl:value-of
											select="notification_data/request/display/place_of_publication" />
								
									</td>
								</tr>
							</xsl:if>
							<xsl:if test="notification_data/request/display/publication_date !=''">
								<tr>
									<td>
										<strong> @@publication_date@@: </strong>
										<xsl:value-of
											select="notification_data/request/display/publication_date" />
							
									</td>
								</tr>
							</xsl:if>
							<xsl:if test="notification_data/request/display/year !=''">
								<tr>
									<td>
										<strong> @@year@@: </strong>
										<xsl:value-of select="notification_data/request/display/year" />
								
									</td>
								</tr>
							</xsl:if>
							<xsl:if test="notification_data/request/display/edition !=''">
								<tr>
									<td>
										<strong> @@edition@@: </strong>
										<xsl:value-of select="notification_data/request/display/edition" />
								
									</td>
								</tr>
							</xsl:if>
							<xsl:if test="notification_data/request/display/call_number !=''">
								<tr>
									<td>
										<strong> @@call_number@@: </strong>
										<xsl:value-of select="notification_data/request/display/call_number" />
									
									</td>
								</tr>
							</xsl:if>
							<xsl:if test="notification_data/request/display/volume !=''">
								<tr>
									<td>
										<strong> @@volume@@: </strong>
										<xsl:value-of select="notification_data/request/display/volume" />
									
									</td>
								</tr>
							</xsl:if>
							<xsl:if test="notification_data/request/display/issue !=''">
								<tr>
									<td>
										<strong> @@issue@@: </strong>
										<xsl:value-of select="notification_data/request/display/issue" />
								
									</td>
								</tr>
							</xsl:if>
							<xsl:if
								test="notification_data/request/display/additional_person_name !=''">
								<tr>
									<td>
										<strong> @@additional_person_name@@: </strong>
										<xsl:value-of
											select="notification_data/request/display/additional_person_name" />
							
									</td>
								</tr>
							</xsl:if>
							<xsl:if test="notification_data/request/display/source !=''">
								<tr>
									<td>
										<strong> @@source@@: </strong>
										<xsl:value-of select="notification_data/request/display/source" />
									
									</td>
								</tr>
							</xsl:if>
							<xsl:if
								test="notification_data/request/display/series_title_number !=''">
								<tr>
									<td>
										<strong> @@series_title_number@@: </strong>
										<xsl:value-of
											select="notification_data/request/display/series_title_number" />
							
									</td>
								</tr>
							</xsl:if>
							<xsl:if test="notification_data/request/display/isbn !=''">
								<tr>
									<td>
										<strong> @@isbn@@: </strong>
										<xsl:value-of select="notification_data/request/display/isbn" />
								
									</td>
								</tr>
							</xsl:if>
							<xsl:if test="notification_data/request/display/issn !=''">
								<tr>
									<td>
										<strong> @@issn@@: </strong>
										<xsl:value-of select="notification_data/request/display/issn" />
										
									</td>
								</tr>
							</xsl:if>
							<xsl:if test="notification_data/request/display/doi !=''">
								<tr>
									<td>
										<strong> @@doi@@: </strong>
										<xsl:value-of select="notification_data/request/display/doi" />
										
									</td>
								</tr>
							</xsl:if>
							<xsl:if test="notification_data/request/display/pmid !=''">
								<tr>
									<td>
										<strong> @@pmid@@: </strong>
										<xsl:value-of select="notification_data/request/display/pmid" />
									
									</td>
								</tr>
							</xsl:if> 
							<xsl:if test="notification_data/request/display/note !=''">
								<tr>
									<td>
										<strong> @@note@@: </strong>
										<xsl:value-of select="notification_data/request/display/note" />
						
									</td>
								</tr>
							</xsl:if>
							<xsl:if test="notification_data/request/display/chapter !=''">
								<tr>
									<td>
										<strong> @@chapter@@: </strong>
										<xsl:value-of select="notification_data/request/display/chapter" />
								
									</td>
								</tr>
							</xsl:if>
							<xsl:if test="notification_data/request/display/volume_bk !=''">
								<tr>
									<td>
										<strong> @@volume@@: </strong>
										<xsl:value-of select="notification_data/request/display/volume_bk" />
					
									</td>
								</tr>
							</xsl:if>
							<xsl:if test="notification_data/request/display/part !=''">
								<tr>
									<td>
										<strong> @@part@@: </strong>
										<xsl:value-of select="notification_data/request/display/part" />
						
									</td>
								</tr>
							</xsl:if>
							<xsl:if test="notification_data/request/display/pages !=''">
								<tr>
									<td>
										<strong> @@pages@@: </strong>
										<xsl:value-of select="notification_data/request/display/pages" />
							
									</td>
								</tr>
							</xsl:if>
							<xsl:if test="notification_data/request/display/start_page !=''">
								<tr>
									<td>
										<strong> @@start_page@@: </strong>
										<xsl:value-of select="notification_data/request/display/start_page" />
							
									</td>
								</tr>
							</xsl:if>
							<xsl:if test="notification_data/request/display/end_page !=''">
								<tr>
									<td>
										<strong> @@end_page@@: </strong>
										<xsl:value-of select="notification_data/request/display/end_page" />
							
									</td>
								</tr>
							</xsl:if>
							<xsl:if test="notification_data/request/note !=''">
								<tr>
									<td>
										<strong> @@request_note@@: </strong>
										<xsl:value-of select="notification_data/request/note" />
							
									</td>
								</tr>
							</xsl:if>
							<xsl:if test="notification_data/general_data/current_date !=''">
								<tr>
									<td>
										<strong> @@date@@: </strong>
										<xsl:value-of select="notification_data/general_data/current_date" />
					
									</td>
								</tr>
							</xsl:if>
							<xsl:if test="notification_data/request/external_request_id !=''">
								<tr>
									<td>
										<strong> @@request_id@@: </strong>
										<xsl:value-of select="notification_data/request/external_request_id" />
							
									</td>
								</tr>
							</xsl:if>
							<xsl:if test="notification_data/request/format_display !=''">
								<tr>
									<td>
										<strong> @@request_format@@: </strong>
										<xsl:value-of select="notification_data/request/format_display" />
						
									</td>
								</tr>
							</xsl:if>
							<xsl:if test="notification_data/request/max_fee !=''">
								<tr>
									<td>
										<strong>@@maximum_fee@@: </strong>
										<xsl:value-of select="notification_data/request/max_fee" />
									</td>

								</tr>
							</xsl:if>




-->
						</table>
						<br />

					<!--	<table role='presentation' >

							<tr>
								<td>@@query_to_patron@@: </td>
							</tr>
							<xsl:choose>
								<xsl:when test="notification_data/query_type = 'Type_1_query_name'">
									<tr>
										<td>@@Type_1_query_line_1@@</td>
									</tr>
									<tr>
										<td>@@Type_1_query_line_2@@</td>
									</tr>
									<tr>
										<td>@@Type_1_query_line_3@@</td>
									</tr>
								</xsl:when>
								<xsl:when test="notification_data/query_type = 'Type_2_query_name'">
									<tr>
										<td>@@Type_2_query_line_1@@</td>
									</tr>
									<tr>
										<td>@@Type_2_query_line_2@@</td>
									</tr>
									<tr>
										<td>@@Type_2_query_line_3@@</td>
									</tr>
								</xsl:when>
								<xsl:otherwise>
									<tr>
										<td>@@Type_1_query_line_1@@</td>
									</tr>
									<tr>
										<td>@@Type_1_query_line_2@@</td>
									</tr>
									<tr>
										<td>@@Type_1_query_line_3@@</td>
									</tr>
								</xsl:otherwise>
							</xsl:choose>

						</table> -->
						<br />
						<table role='presentation' >
							<xsl:if test="notification_data/query_note !=''">
								<tr>
									<td>
										<!-- <strong> @@query_note@@: </strong> -->
										<xsl:value-of select="notification_data/query_note" />
									</td>
								</tr>
							</xsl:if>

						</table>
						<br />
						<table role='presentation' >

							<tr>
								<td>@@Type_1_Sincerely@@</td>
							</tr>
							<xsl:if test="notification_data/library/name !=''">
								<tr>
									<td>
									<!--	<xsl:value-of select="notification_data/library/name" /> --> Bibliothèque de l'Université de Genève
									</td>
								</tr>
							</xsl:if>
							<xsl:if test="notification_data/library/address/line1 !=''">
								<tr>
									<td>
										<xsl:value-of select="notification_data/library/address/line1" />
									</td>
								</tr>
							</xsl:if>
							<xsl:if test="notification_data/library/address/line2 !=''">
								<tr>
									<td>
										<xsl:value-of select="notification_data/library/address/line2" />
									</td>
								</tr>
							</xsl:if>
							<xsl:if test="notification_data/library/address/line3 !=''">
								<tr>
									<td>
										<xsl:value-of select="notification_data/library/address/line3" />
									</td>
								</tr>
							</xsl:if>
							<xsl:if test="notification_data/library/address/line4 !=''">
								<tr>
									<td>
										<xsl:value-of select="notification_data/library/address/line4" />
									</td>
								</tr>
							</xsl:if>
							<xsl:if test="notification_data/library/address/line5 !=''">
								<tr>
									<td>
										<xsl:value-of select="notification_data/library/address/line5" />
									</td>
								</tr>
							</xsl:if>
							<xsl:if test="notification_data/library/address/city !=''">
								<tr>
									<td>
										<xsl:value-of select="notification_data/library/address/city" />
									</td>
								</tr>
							</xsl:if>
							<!-- <xsl:if test="notification_data/library/address/country !=''">
								<tr>
									<td>
										<xsl:value-of select="notification_data/library/address/country" />
									</td>
								</tr>

							 </xsl:if> -->
							<!--<xsl:if test="notification_data/signature_email !=''">
								<tr>
									<td>
										<xsl:value-of select="notification_data/signature_email" />
									</td>
								</tr>

							</xsl:if> -->
						</table>
					</div>
				</div>
                <br/>
                <p>
                    <i>powered by SLSP</i>
                </p>
				<!-- footer.xsl -->
			</body>
		</html>
	</xsl:template>
</xsl:stylesheet>
