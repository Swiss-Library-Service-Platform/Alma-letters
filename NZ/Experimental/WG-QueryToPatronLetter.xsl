<?xml version="1.0" encoding="utf-8"?>
<!-- SLSP WG: Letters version 08/2021 -->
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

				<!-- <table role='presentation'  cellspacing="0" cellpadding="5" border="0">
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
				</table> -->

				<div class="messageArea">
					<div class="messageBody">
						<table role='presentation'  cellspacing="0" cellpadding="5" border="0">
							<tr>
								<td>
									@@request_id@@: <xsl:value-of select="notification_data/request/ful_request_id"/>
									<br />
								</td>
							</tr>
							<tr>
								<td>
									@@requested@@ <xsl:value-of select="notification_data/request/create_date"/>:
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
										<strong><xsl:value-of select="notification_data/request/display/title" /></strong>
									</xsl:if>
									<xsl:if test="notification_data/request/display/author !=''">
										<br />
										@@author@@: <xsl:value-of select="notification_data/request/display/author" />
									</xsl:if>
									<xsl:if test="notification_data/request/display/place_of_publication !=''">
										<br />
										<xsl:value-of select="notification_data/request/display/place_of_publication" />
									</xsl:if><xsl:if test="notification_data/request/display/publisher !=''">:
										<xsl:value-of select="notification_data/request/display/publisher" />
									</xsl:if><xsl:if test="notification_data/request/display/publication_date !=''">,
										<xsl:value-of select="notification_data/request/display/publication_date" />
									</xsl:if>
									<xsl:if test="notification_data/request/display/edition !=''">
										<br />
										@@edition@@: <xsl:value-of select="notification_data/request/display/edition" />
									</xsl:if>
									<xsl:if test="notification_data/request/display/journal_title !=''">
										<br />
										@@journal_title@@: <xsl:value-of select="notification_data/request/display/journal_title" />
									</xsl:if>
									<xsl:if test="notification_data/request/display/volume !=''">
										, <xsl:value-of select="notification_data/request/display/volume" />
									</xsl:if>
									<xsl:if test="notification_data/request/display/issue !=''">
												, <xsl:value-of select="notification_data/request/display/issue" />
									</xsl:if>
									<xsl:if test="notification_data/request/display/isbn !=''">
										<br />
										@@isbn@@: <xsl:value-of select="notification_data/request/display/isbn" />
									</xsl:if>
									<xsl:if test="notification_data/request/display/issn !=''">
										<br />
										@@issn@@: <xsl:value-of select="notification_data/request/display/issn" />		
									</xsl:if>
									<xsl:if test="notification_data/request/display/pages !=''">
										<br />
										@@pages@@: <xsl:value-of select="notification_data/request/display/issn" />		
									</xsl:if>
								</td>
							</tr>
						</table>
						<br />

					<!--	
						Section with logic for printing the labels corresponding to the letter type. Adapt if necessary.
						<table role='presentation' >

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
										<strong>@@query_note@@</strong>:<br />
										<xsl:value-of select="notification_data/query_note" />
									</td>
								</tr>
							</xsl:if>

						</table>
						<br />

						<!-- 
							Code for inserting reply to e-mail in the Letter body. One per each letter type.
							Prerequisities:
								Type_1_query_line_1 - label to introduce the reply e-mail
								Type_1_query_line_2 - reply to e-mail
								Type_1_query_line_3 - Label for subject in the reply e-mail from patron
								Example:
								Type_1_query_line_1 - Please reply to 
								Type_1_query_line_2 - ILL@abc.ch
								Type_1_query_line_3 - Answer for request  -->
						<xsl:if test="notification_data/query_type = 'Type_1_query_name'">
							<p>
								<strong>@@Type_1_query_line_1@@</strong>
								<a>
									<xsl:attribute name="href">
										mailto:@@Type_1_query_line_2@@?subject=@@Type_1_query_line_3@@<xsl:value-of select="notification_data/request/ful_request_id"/>&#38;body=@@query_note@@:&#160;<xsl:value-of select="notification_data/query_note" />
									</xsl:attribute>
									@@Type_1_query_line_2@@
								</a>
							</p>
						</xsl:if>
						<br />
						
						<table role='presentation' >

							<tr>
								<td>@@Type_1_Sincerely@@</td>
							</tr>
							<xsl:if test="notification_data/organization_unit/name !=''">
								<tr>
									<td>
										<xsl:value-of select="notification_data/organization_unit/name" />
									</td>
								</tr>
							</xsl:if>
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
