<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform" 
                xmlns:x="http://www.tei-c.org/ns/1.0"
                xmlns:my="https://github.com/chchch/tst"
                exclude-result-prefixes="x my">
<xsl:output method="html" encoding="UTF-8" omit-xml-declaration="yes"/>

<xsl:template match="x:TEI">
    <xsl:element name="html">
        <xsl:element name="head">
            <xsl:element name="meta">
                <xsl:attribute name="charset">utf-8</xsl:attribute>
            </xsl:element>
            <xsl:element name="meta">
                <xsl:attribute name="name">viewport</xsl:attribute>
                <xsl:attribute name="content">width=device-width,initial-scale=1</xsl:attribute>
            </xsl:element>
            <xsl:element name="title">
                <xsl:value-of select="//x:titleStmt/x:title"/>
            </xsl:element>
            <xsl:element name="link">
                <xsl:attribute name="rel">stylesheet</xsl:attribute>
                <xsl:attribute name="href">../lib/tufte.css</xsl:attribute>
            </xsl:element>
            <xsl:element name="link">
                <xsl:attribute name="rel">stylesheet</xsl:attribute>
                <xsl:attribute name="href">../lib/tst.css</xsl:attribute>
            </xsl:element>
            <xsl:element name="script">
                <xsl:attribute name="type">text/javascript</xsl:attribute>
                <xsl:attribute name="src">../lib/sanscript.js</xsl:attribute>
            </xsl:element>
            <xsl:element name="script">
                <xsl:attribute name="type">text/javascript</xsl:attribute>
                <xsl:attribute name="src">../lib/transliterate.js</xsl:attribute>
            </xsl:element>
            <xsl:element name="script">
                <xsl:attribute name="type">text/javascript</xsl:attribute>
                <xsl:attribute name="src">../lib/viewpos.js</xsl:attribute>
            </xsl:element>
            <xsl:element name="script">
                <xsl:attribute name="type">text/javascript</xsl:attribute>
                <xsl:attribute name="src">../lib/hypher-nojquery.js</xsl:attribute>
            </xsl:element>
            <xsl:element name="script">
                <xsl:attribute name="type">text/javascript</xsl:attribute>
                <xsl:attribute name="src">../lib/sa.js</xsl:attribute>
            </xsl:element>
            <xsl:element name="script">
                <xsl:attribute name="type">text/javascript</xsl:attribute>
                <xsl:attribute name="src">../lib/ta.js</xsl:attribute>
            </xsl:element>
            <xsl:element name="script">
                <xsl:attribute name="type">text/javascript</xsl:attribute>
                <xsl:attribute name="src">../lib/ta-Latn.js</xsl:attribute>
            </xsl:element>
            <xsl:element name="script">
                <xsl:attribute name="type">text/javascript</xsl:attribute>
                <xsl:attribute name="src">https://unpkg.com/mirador@latest</xsl:attribute>
            </xsl:element>
            <xsl:element name="script">
                <xsl:attribute name="type">text/javascript</xsl:attribute>
                <xsl:attribute name="src">../lib/tst.js</xsl:attribute>
            </xsl:element>
        </xsl:element>
        <xsl:element name="body">
            <xsl:attribute name="lang">en</xsl:attribute>   
            <xsl:element name="div">
                <xsl:attribute name="id">recordcontainer</xsl:attribute>
                <xsl:element name="div">
                    <xsl:choose>
                        <xsl:when test="x:facsimile/x:graphic">
                            <xsl:attribute name="id">record-thin</xsl:attribute>
                        </xsl:when>
                        <xsl:otherwise>
                            <xsl:attribute name="id">record-fat</xsl:attribute>
                        </xsl:otherwise>
                    </xsl:choose>
                    <xsl:element name="div">
                        <xsl:attribute name="id">topbar</xsl:attribute>
                        <xsl:element name="div">
                            <xsl:attribute name="id">transbutton</xsl:attribute>
                            <xsl:attribute name="title">change script</xsl:attribute>
                            <xsl:text>A</xsl:text>
                        </xsl:element>
                    </xsl:element>
                    <xsl:element name="article">
                        <xsl:apply-templates/>
                    </xsl:element>
                </xsl:element>
            </xsl:element>
            <xsl:if test="x:facsimile/x:graphic">
                <xsl:element name="div">
                    <xsl:attribute name="id">viewer</xsl:attribute>
                    <xsl:attribute name="data-manifest">
                        <xsl:value-of select="x:facsimile/x:graphic/@url"/>
                    </xsl:attribute>
                </xsl:element>
            </xsl:if>
        </xsl:element>
    </xsl:element>
</xsl:template>

<xsl:template name="lang">
    <xsl:if test="@xml:lang">
        <xsl:attribute name="lang"><xsl:value-of select="@xml:lang"/></xsl:attribute>
    </xsl:if>
</xsl:template>

<xsl:template name="repeat">
    <xsl:param name="output" />
    <xsl:param name="count" />
    <xsl:if test="$count &gt; 0">
        <xsl:value-of select="$output" />
        <xsl:call-template name="repeat">
            <xsl:with-param name="output" select="$output" />
            <xsl:with-param name="count" select="$count - 1" />
        </xsl:call-template>
    </xsl:if>
</xsl:template>

<xsl:template match="x:teiHeader">
    <xsl:element name="section">
        <xsl:call-template name="lang"/>
        <xsl:apply-templates />
    </xsl:element>
</xsl:template>

<xsl:template match="x:milestone">
    <xsl:element name="span">
        <xsl:attribute name="class">milestone</xsl:attribute>
        <xsl:attribute name="lang">en</xsl:attribute>
        <xsl:apply-templates select="@facs"/>
        <xsl:choose>
        <xsl:when test="@unit">
            <xsl:value-of select="@unit"/>
            <xsl:text> </xsl:text>
        </xsl:when>
        <xsl:when test="/x:TEI/x:teiHeader/x:fileDesc/x:sourceDesc/x:msDesc/x:physDesc/x:objectDesc[@form = 'pothi']">
            <xsl:text>folio </xsl:text>
        </xsl:when>
<xsl:when test="/x:TEI/x:teiHeader/x:fileDesc/x:sourceDesc/x:msDesc/x:physDesc/x:objectDesc[@form = 'book']">
            <xsl:text>page </xsl:text>
        </xsl:when>
        </xsl:choose>
<xsl:value-of select="@n"/>
    </xsl:element>
</xsl:template>

<xsl:template match="x:locus">
    <xsl:element name="span">
        <xsl:attribute name="class">
            <xsl:text>locus </xsl:text>
            <xsl:value-of select="@rend"/>
        </xsl:attribute>
        <xsl:apply-templates select="@facs"/>
        <xsl:call-template name="lang"/>
        <xsl:apply-templates/>
    </xsl:element>
</xsl:template>

<xsl:template match="@facs">
    <xsl:attribute name="data-loc">
        <xsl:value-of select="."/>
    </xsl:attribute>
    <xsl:attribute name="data-anno">
        <xsl:text>image </xsl:text>
        <xsl:value-of select="."/>
    </xsl:attribute>
</xsl:template>

<xsl:template match="x:lb">
    <xsl:element name="span">
        <xsl:attribute name="class">lb</xsl:attribute>
        <xsl:attribute name="lang">en</xsl:attribute>
        <xsl:apply-templates select="@n"/>
        <xsl:text>&#x2424;</xsl:text>
    </xsl:element>
</xsl:template>

<xsl:template match="x:lb/@n">
    <xsl:attribute name="data-anno">
        <xsl:text>line </xsl:text>
        <xsl:value-of select="."/>
    </xsl:attribute>
</xsl:template>
<xsl:template match="x:pb/@n">
    <xsl:attribute name="data-anno">
        <xsl:variable name="unit" select="//x:extent/x:measure/@unit"/>
        <xsl:choose>
            <xsl:when test="$unit">
                <xsl:value-of select="$unit"/><xsl:text> </xsl:text>
            </xsl:when>
            <xsl:otherwise>
                <xsl:text>page </xsl:text>
            </xsl:otherwise>
        </xsl:choose>
        <xsl:value-of select="."/>
    </xsl:attribute>
</xsl:template>

<xsl:template match="x:pb">
<xsl:element name="span">
    <xsl:attribute name="class">pb</xsl:attribute>
    <xsl:attribute name="lang">en</xsl:attribute>
    <xsl:apply-templates select="@n"/>
    <xsl:apply-templates select="@facs"/>
    <xsl:text>&#x2424;</xsl:text>
</xsl:element>
</xsl:template>

<xsl:template match="x:sup">
    <xsl:element name="sup">
        <xsl:call-template name="lang"/>
        <xsl:apply-templates />
    </xsl:element>
</xsl:template>

<xsl:template match="x:sub">
    <xsl:element name="sub">
        <xsl:call-template name="lang"/>
        <xsl:apply-templates />
    </xsl:element>
</xsl:template>

<xsl:template match="x:quote | x:q">
    <xsl:element name="span">
        <xsl:call-template name="lang"/>
        <xsl:attribute name="class">quote</xsl:attribute>
        <xsl:apply-templates />
    </xsl:element>
</xsl:template>

<xsl:template match="x:quote[@rend='block']">
    <xsl:element name="blockquote">
        <xsl:call-template name="lang"/>
        <xsl:apply-templates />
    </xsl:element>
</xsl:template>

<xsl:template match="x:foreign">
    <xsl:element name="em">
        <xsl:call-template name="lang"/>
        <xsl:apply-templates />
    </xsl:element>
</xsl:template>

<xsl:template match="x:term">
    <xsl:element name="span">
        <xsl:call-template name="lang"/>
        <xsl:attribute name="class">
            <xsl:text>term </xsl:text>
            <xsl:value-of select="@rend"/>
        </xsl:attribute>
        <xsl:apply-templates />
    </xsl:element>
</xsl:template>

<xsl:template match="x:titleStmt/x:title">
    <xsl:element name="h1">
        <xsl:call-template name="lang"/>
        <xsl:apply-templates/>
    </xsl:element>
</xsl:template>

<!--xsl:template match="x:titleStmt/x:editor">
    <h4>Edited by <xsl:apply-templates/></h4>
</xsl:template-->

<xsl:template match="x:titleStmt/x:respStmt">
    <p><xsl:apply-templates/></p>
</xsl:template>

<xsl:template match="x:respStmt/x:resp">
    <xsl:apply-templates/>
</xsl:template>

<xsl:template match="x:respStmt/x:name">
    <xsl:apply-templates/>
</xsl:template>

<xsl:template match="x:publicationStmt">
    <xsl:element name="p">
        <xsl:text>Published in </xsl:text>
        <xsl:apply-templates select="x:date"/>
        <xsl:text> by </xsl:text>
        <xsl:apply-templates select="x:publisher"/> 
        <xsl:if test="x:pubPlace">
            <xsl:text>in </xsl:text><xsl:apply-templates select="x:pubPlace"/>
        </xsl:if>
        <xsl:text>.</xsl:text>
    </xsl:element>
</xsl:template>

<xsl:template match="x:editionStmt">
    <xsl:element name="div">
        <xsl:attribute name="class">editionStmt</xsl:attribute>
        <xsl:apply-templates/>
    </xsl:element>
</xsl:template>

<xsl:template match="x:title">
    <xsl:element name="em">
        <xsl:attribute name="class">title</xsl:attribute>
        <xsl:call-template name="lang"/>
        <xsl:apply-templates />
    </xsl:element>
</xsl:template>

<xsl:template match="x:title[@type='article']">
    <xsl:element name="em">
        <xsl:attribute name="class">title-article</xsl:attribute>
        <xsl:call-template name="lang"/>
        <xsl:apply-templates />
    </xsl:element>
</xsl:template>

<xsl:template match="x:msContents/x:summary/x:title">
    <xsl:element name="em">
        <xsl:call-template name="lang"/>
        <xsl:apply-templates/>
    </xsl:element>
</xsl:template>

<xsl:template match="x:msContents/x:summary/x:sub">
    <xsl:element name="sub">
        <xsl:apply-templates/>
    </xsl:element>
</xsl:template>
<xsl:template match="x:msContents/x:summary/x:sup">
    <xsl:element name="sup">
        <xsl:apply-templates/>
    </xsl:element>
</xsl:template>

<xsl:template match="x:msIdentifier">
    <table id="msidentifier">
        <xsl:apply-templates select="x:repository"/>
        <xsl:apply-templates select="x:institution"/>
        <xsl:apply-templates select="x:idno"/>
    </table>
</xsl:template>

<xsl:template match="x:repository">
    <tr><td colspan="2"><xsl:apply-templates/></td></tr>
</xsl:template>
<xsl:template match="x:institution">
    <tr><td colspan="2"><xsl:apply-templates/></td></tr>
</xsl:template>
<xsl:template match="x:orgName">
    <xsl:element name="span">
        <xsl:attribute name="class">orgname</xsl:attribute>
        <xsl:call-template name="lang"/>
        <xsl:apply-templates/>
    </xsl:element>
</xsl:template>

<xsl:template match="x:idno[not(@type='URI')]">
    <tr><th>
        <xsl:if test="@type">
            <xsl:value-of select="@type"/>
        </xsl:if>
        </th>
        <td>
            <xsl:apply-templates/>
        </td>
    </tr>
</xsl:template>
<xsl:template match="x:idno[@type='URI']">
    <tr><td colspan="2">
        <xsl:element name="a">
            <xsl:attribute name="href"><xsl:value-of select="."/></xsl:attribute>
            <xsl:apply-templates/>
        </xsl:element>
    </td></tr>
</xsl:template>

<xsl:template match="x:fileDesc">
    <xsl:apply-templates/>
</xsl:template>
<xsl:template match="x:titleStmt">
    <xsl:apply-templates/>
</xsl:template>
<xsl:template match="x:sourceDesc">
    <xsl:apply-templates/>
</xsl:template>

<xsl:template name="msDescTemplate">
    <xsl:apply-templates select="x:head"/>
    <xsl:apply-templates select="x:msIdentifier"/>
    <xsl:apply-templates select="x:msContents"/>
    <xsl:apply-templates select="x:physDesc"/>
    <section>
        <h3>Contents</h3>
        <xsl:apply-templates select="x:msContents/@class"/>
        <xsl:apply-templates select="x:msContents/x:msItem"/>
        <xsl:apply-templates select="x:msPart"/>
        <xsl:if test="x:msPart">
            <hr/>
        </xsl:if>
    </section>
    <xsl:apply-templates select="x:history"/>
    <xsl:apply-templates select="x:additional"/>
</xsl:template>

<xsl:template match="x:msDesc">
    <xsl:call-template name="msDescTemplate"/>
</xsl:template>

<xsl:template match="x:msPart">
    <hr/>
    <section class="mspart">
        <xsl:call-template name="msDescTemplate"/>
    </section>
</xsl:template>

<xsl:template match="x:msPart/x:head">
    <h4 class="mspart"><xsl:apply-templates/></h4>
</xsl:template>

<xsl:template match="x:msContents">
    <xsl:apply-templates select="x:summary"/>
</xsl:template>

<my:mstypes>
    <my:entry key="#STM">Single-text manuscript</my:entry>
    <my:entry key="#MTM">Multi-text manuscript</my:entry>
    <my:entry key="#CM">Composite manuscript</my:entry>
    <my:entry key="#MVM">Multi-volume manuscript</my:entry>
</my:mstypes>

<xsl:template match="x:msContents/@class">
    <xsl:variable name="class" select="."/>
    <xsl:element name="p">
        <xsl:value-of select="document('')/*/my:mstypes/my:entry[@key=$class]"/>
        <xsl:text>.</xsl:text>
    </xsl:element>
</xsl:template>

<xsl:template match="x:msItem">
  <table class="msItem">
    <xsl:variable name="thisn" select="@n"/>
    <xsl:element name="thead">
        <xsl:element name="tr">
            <xsl:element name="th">
                <xsl:attribute name="colspan">2</xsl:attribute>
                <xsl:attribute name="class">left-align</xsl:attribute>
                <xsl:choose>
                    <xsl:when test="@n">
                        <xsl:choose>
                            <xsl:when test="//x:TEI/x:text[@n=$thisn]">
                                <xsl:element name="a">
                                    <xsl:attribute name="href">
                                        <xsl:text>#text-</xsl:text>
                                        <xsl:value-of select="@n"/>
                                    </xsl:attribute>
                                    <xsl:attribute name="data-scroll"/>
                                    <xsl:value-of select="@n"/>
                                </xsl:element>
                            </xsl:when>
                            <xsl:otherwise>
                            <xsl:value-of select="@n"/>
                            </xsl:otherwise>
                        </xsl:choose>
                        <xsl:choose>
                            <xsl:when test="@defective = 'false'">
                                <xsl:text> (complete)</xsl:text>
                            </xsl:when>
                            <xsl:when test="@defective = 'true'">
                                <xsl:text> (incomplete)</xsl:text>
                            </xsl:when>
                            <xsl:otherwise/>
                        </xsl:choose>
                    </xsl:when>
                    <xsl:otherwise>
                        <xsl:choose>
                            <xsl:when test="@defective = 'false'">
                                <xsl:text>(complete)</xsl:text>
                            </xsl:when>
                            <xsl:when test="@defective = 'true'">
                                <xsl:text>(incomplete)</xsl:text>
                            </xsl:when>
                            <xsl:otherwise/>
                        </xsl:choose>
                    </xsl:otherwise>
                </xsl:choose>
            </xsl:element>
        </xsl:element>
    </xsl:element>
    <xsl:apply-templates/>
  </table>
  <xsl:if test="not(position() = last())">
    <xsl:element name="hr"/>
  </xsl:if>
</xsl:template>

<xsl:template match="x:msItem/x:title[not(@type)]">
    <tr>
      <th>Title</th>
        <xsl:element name="td">
            <xsl:call-template name="lang"/>
            <xsl:apply-templates />
        </xsl:element>
    </tr>
</xsl:template>

<xsl:template match="x:msItem/x:title[@type='commentary']">
  <tr>
    <th>Commentary</th>
    <xsl:element name="td">
        <xsl:call-template name="lang"/>
        <xsl:apply-templates />
    </xsl:element>
  </tr>
</xsl:template>

<xsl:template match="x:msItem/x:author">
  <tr>
    <th>Author</th>
    <xsl:element name="td">
        <xsl:call-template name="lang"/>
        <xsl:apply-templates />
    </xsl:element>
  </tr>
</xsl:template>
<xsl:template match="x:msItem/x:author[@role='commentator']">
  <tr>
    <th>Commentator</th>
    <xsl:element name="td">
        <xsl:call-template name="lang"/>
        <xsl:apply-templates />
    </xsl:element>
  </tr>
</xsl:template>

<my:langs>
    <my:entry key="eng">English</my:entry>
    <my:entry key="fra">French</my:entry>
    <my:entry key="pal">Pali</my:entry>
    <my:entry key="por">Portuguese</my:entry>
    <my:entry key="pra">Prakrit</my:entry>
    <my:entry key="san">Sanskrit</my:entry>
    <my:entry key="tam">Tamil</my:entry>
</my:langs>

<xsl:template match="x:textLang">
    <tr>
        <th>Language</th>
        <xsl:element name="td">
            <xsl:variable name="mainLang" select="@mainLang"/>
            <xsl:attribute name="class">record_languages</xsl:attribute>
            <xsl:attribute name="data-mainlang"><xsl:value-of select="$mainLang"/></xsl:attribute>
            <xsl:attribute name="data-otherlangs"><xsl:value-of select="@otherLangs"/></xsl:attribute>
            <xsl:value-of select="document('')/*/my:langs/my:entry[@key=$mainLang]"/>
            <xsl:if test="@otherLangs and not(@otherLangs='')">
                <xsl:text> (</xsl:text>
                <xsl:call-template name="splitlist">
                    <xsl:with-param name="list" select="@otherLangs"/>
                    <xsl:with-param name="nocapitalize">true</xsl:with-param>
                    <xsl:with-param name="map">my:langs</xsl:with-param>
                </xsl:call-template>
                <xsl:text>)</xsl:text>
            </xsl:if>
        </xsl:element>
    </tr>
</xsl:template>

<xsl:template match="x:rubric">
   <tr>
     <th>Rubric</th>
     <xsl:element name="td">
        <xsl:attribute name="class">excerpt</xsl:attribute>
        <xsl:call-template name="lang"/>
        <xsl:apply-templates/>
     </xsl:element>
   </tr>
</xsl:template> 
<xsl:template match="x:finalRubric">
   <tr>
     <th>Final rubric</th>
     <xsl:element name="td">
        <xsl:attribute name="class">excerpt</xsl:attribute>
        <xsl:call-template name="lang"/>
        <xsl:apply-templates/>
     </xsl:element>
   </tr>
</xsl:template>
<xsl:template match="x:incipit">
   <tr>
     <th>Incipit</th>
     <xsl:element name="td">
        <xsl:attribute name="class">excerpt</xsl:attribute>
        <xsl:call-template name="lang"/>
        <xsl:apply-templates/>
     </xsl:element>
   </tr>
</xsl:template>
<xsl:template match="x:explicit">
   <tr>
     <th>Explicit</th>
     <xsl:element name="td">
        <xsl:attribute name="class">excerpt</xsl:attribute>
        <xsl:call-template name="lang"/>
        <xsl:apply-templates/>
     </xsl:element>
   </tr>
</xsl:template>
<xsl:template match="x:colophon">
   <tr>
     <th>Colophon</th>
     <xsl:element name="td">
        <xsl:attribute name="class">excerpt</xsl:attribute>
        <xsl:call-template name="lang"/>
        <xsl:apply-templates/>
     </xsl:element>
   </tr>
</xsl:template>

<xsl:template match="x:msItem//x:note">
    <xsl:element name="p">
        <xsl:call-template name="lang"/>
        <xsl:apply-templates/>
    </xsl:element>
</xsl:template>

<xsl:template match="x:span">
    <xsl:element name="span">
        <xsl:call-template name="lang"/>
        <xsl:apply-templates/>
    </xsl:element>
</xsl:template>

<xsl:template match="x:filiation">
    <tr>
        <th>Other manuscript testimonies</th>
        <xsl:element name="td">
            <xsl:apply-templates/>
        </xsl:element>
    </tr>
</xsl:template>

<xsl:template match="x:summary">
    <xsl:element name="section">
        <xsl:attribute name="id">summary</xsl:attribute>
        <xsl:call-template name="lang"/>
        <xsl:choose>
            <xsl:when test="x:p">
                <xsl:apply-templates/>
            </xsl:when>
            <xsl:otherwise>
                <xsl:element name="p">
                    <xsl:apply-templates/>
                </xsl:element>
            </xsl:otherwise>
        </xsl:choose>
    </xsl:element>
</xsl:template>

<xsl:template match="x:physDesc">
  <section>
      <h3>Physical description</h3>
      <table id="physDesc">
      <xsl:apply-templates select="x:objectDesc/@form"/>
      <xsl:apply-templates select="x:objectDesc/x:supportDesc/@material"/>
      <xsl:apply-templates select="x:objectDesc/x:supportDesc/x:extent"/>
      <xsl:if test="x:objectDesc/x:supportDesc/x:foliation">
          <tr>
            <th>Foliation</th>
            <td><ul>
              <xsl:apply-templates select="x:objectDesc/x:supportDesc/x:foliation"/>
            </ul></td>
          </tr>
      </xsl:if>
      <xsl:apply-templates select="x:objectDesc/x:supportDesc/x:condition"/>
      <xsl:apply-templates select="x:objectDesc/x:layoutDesc"/>
      <xsl:apply-templates select="x:handDesc"/>
      <xsl:apply-templates select="x:decoDesc"/>
      <xsl:apply-templates select="x:additions"/>
      <xsl:apply-templates select="x:bindingDesc"/>
      </table>
  </section>
</xsl:template>

<xsl:template match="x:scriptDesc">
    <ul>
    <xsl:apply-templates select="x:scriptNote"/>
    </ul>
</xsl:template>
<xsl:template match="x:scriptNote">
      <li><xsl:apply-templates/></li>
</xsl:template>

<xsl:template match="x:objectDesc/@form">
  <tr>
    <th>Format</th> <td><xsl:call-template name="capitalize"><xsl:with-param name="str" select="."/></xsl:call-template></td>
  </tr>
</xsl:template>

<my:materials>
    <my:entry key="paper">Paper</my:entry>
    <my:entry key="paper industrial">Paper (industrial)</my:entry>
    <my:entry key="paper handmade">Paper (handmade)</my:entry>
    <my:entry key="paper laid">Paper (laid)</my:entry>
    <my:entry key="palm-leaf">Palm leaf</my:entry>
    <my:entry key="palm-leaf talipot">Palm leaf (talipot)</my:entry>
    <my:entry key="palm-leaf palmyra">Palm leaf (palmyra)</my:entry>
    <my:entry key="birch-bark">Birch bark</my:entry>
    <my:entry key="copper">Copper</my:entry>
    <my:entry key="leather">Leather</my:entry>
</my:materials>

<xsl:template match="x:objectDesc/x:supportDesc/@material">
  <xsl:variable name="mat" select="."/>
  <xsl:element name="tr">
    <xsl:element name="th">Material</xsl:element>
    <xsl:element name="td">
        <xsl:value-of select="document('')/*/my:materials/my:entry[@key=$mat]"/>
        <xsl:if test="../x:support">
            <xsl:text>. </xsl:text>
            <xsl:apply-templates select="../x:support"/>
        </xsl:if>
    </xsl:element>
  </xsl:element>
</xsl:template>

<xsl:template match="x:objectDesc/x:supportDesc/x:support">
    <xsl:apply-templates/>
</xsl:template>

<xsl:template match="x:measure">
    <xsl:value-of select="@quantity"/>
    <xsl:text> </xsl:text>
    <xsl:value-of select="@unit"/>
    <xsl:text>. </xsl:text>
    <xsl:apply-templates />
</xsl:template>

<xsl:template name="units">
    <xsl:param name="q" select="@quantity"/>
    <xsl:param name="u" select="@unit"/>
    <xsl:value-of select="$q"/>
    <xsl:text> </xsl:text>
    <xsl:value-of select="$u"/>
    <xsl:if test="not($q='1')">
        <xsl:text>s</xsl:text>
    </xsl:if>
</xsl:template>

<xsl:template match="x:measure[@unit='stringhole' or @unit='folio' or @unit='page']">
    <xsl:if test="not(@quantity = '')">
        <xsl:call-template name="units"/>
        <xsl:text>. </xsl:text>
        <xsl:apply-templates />
   </xsl:if>
</xsl:template>

<xsl:template match="x:objectDesc/x:supportDesc/x:extent">
  <tr>
    <th>Extent</th> 
    <td>
        <xsl:apply-templates select="x:measure"/>
    </td>
  </tr>
  <tr>
    <th>Dimensions</th>
    <td>
        <xsl:apply-templates select="x:dimensions"/>
    </td>
  </tr>
</xsl:template>

<xsl:template match="x:dimensions">
    <ul>
        <xsl:choose>
        <xsl:when test="@type">
            <li>
                <span class="type"><xsl:value-of select="@type"/></span>
                <ul>
                    <xsl:apply-templates select="x:width"/>
                    <xsl:apply-templates select="x:height"/>
                    <xsl:apply-templates select="x:depth"/>
                </ul>
            </li>
        </xsl:when>
        <xsl:otherwise>
            <xsl:apply-templates select="x:width"/>
            <xsl:apply-templates select="x:height"/>
            <xsl:apply-templates select="x:depth"/>
        </xsl:otherwise>
        </xsl:choose>
    </ul>
    <xsl:apply-templates select="x:note"/>
</xsl:template>

<xsl:template match="x:dimensions/x:note">
    <xsl:element name="p">
        <xsl:call-template name="lang"/>
        <xsl:apply-templates/>
    </xsl:element>
</xsl:template>

<xsl:template match="x:width">
    <xsl:element name="li">
        <xsl:text>width: </xsl:text>
        <xsl:apply-templates select="@quantity"/>
        <xsl:call-template name="min-max"/>
        <xsl:value-of select="../@unit"/>
    </xsl:element>
</xsl:template>
<xsl:template match="x:height">
    <xsl:element name="li">
        <xsl:text>height: </xsl:text>
        <xsl:apply-templates select="@quantity"/>
        <xsl:call-template name="min-max"/>
        <xsl:value-of select="../@unit"/>
    </xsl:element>
</xsl:template>
<xsl:template match="x:depth">
    <xsl:element name="li">
        <xsl:text>depth: </xsl:text>
        <xsl:apply-templates select="@quantity"/>
        <xsl:call-template name="min-max"/>
        <xsl:value-of select="../@unit"/>
    </xsl:element>
</xsl:template>

<xsl:template match="@quantity">
    <xsl:value-of select="."/>
    <xsl:text> </xsl:text>
</xsl:template>
<xsl:template match="@min">
    <xsl:text>min. </xsl:text>
    <xsl:value-of select="."/>
    <xsl:text> </xsl:text>
</xsl:template>
<xsl:template match="@max">
    <xsl:text>max. </xsl:text>
    <xsl:value-of select="."/>
</xsl:template>

<xsl:template name="min-max">
    <xsl:choose>
        <xsl:when test="@min and not(@min='') and @max and not(@max='')">
            <xsl:value-of select="@min"/><xsl:text>-</xsl:text><xsl:value-of select="@max"/>
        </xsl:when>
        <xsl:otherwise>
            <xsl:if test="@min and not(@min='')"><xsl:apply-templates select="@min"/></xsl:if>
            <xsl:if test="@max and not(@max='')"><xsl:apply-templates select="@max"/></xsl:if>
        </xsl:otherwise>
    </xsl:choose>
    <xsl:text> </xsl:text>
</xsl:template>

<xsl:template name="n-format">
        <xsl:if test="@n">
            <xsl:element name="span">
                <xsl:attribute name="class">lihead</xsl:attribute>
                <xsl:call-template name="splitlist">
                    <xsl:with-param name="list" select="@n"/>
                    <xsl:with-param name="nocapitalize">true</xsl:with-param>
                </xsl:call-template>
            </xsl:element>
        </xsl:if>
</xsl:template>

<xsl:template match="x:objectDesc/x:supportDesc/x:foliation">
    <li>
        <xsl:if test="@n">
            <xsl:call-template name="n-format"/>
            <xsl:text>: </xsl:text>
        </xsl:if>
        <xsl:apply-templates />
    </li>
</xsl:template>

<xsl:template match="x:objectDesc/x:supportDesc/x:condition">
    <tr>
      <th>Condition</th>
      <xsl:element name="td">
        <xsl:call-template name="lang"/>
        <xsl:apply-templates/>
      </xsl:element>
    </tr>
</xsl:template>

<xsl:template match="x:objectDesc/x:layoutDesc">
  <tr>
    <th>Layout</th> 
    <td>
        <ul>
            <xsl:apply-templates/>
        </ul>
    </td>
  </tr>
</xsl:template>

<xsl:template match="x:layout">
    <li>
      <xsl:if test="@n">
        <xsl:element name="span">
            <xsl:attribute name="class">lihead</xsl:attribute>
            <xsl:value-of select="@n"/>
            <xsl:text>: </xsl:text>
        </xsl:element>
      </xsl:if>
      <xsl:if test="@style and not(@style='')">
      <xsl:call-template name="capitalize">
        <xsl:with-param name="str" select="@style"/>
      </xsl:call-template>
      <xsl:text>. </xsl:text>
      </xsl:if>
      <xsl:if test="@columns and not(@columns='')">
        <xsl:variable name="q" select="translate(@columns,' ','-')"/>
        <xsl:call-template name="units">
            <xsl:with-param name="u">column</xsl:with-param>
            <xsl:with-param name="q" select="$q"/>
        </xsl:call-template>
        <xsl:text>. </xsl:text>
      </xsl:if>
      <xsl:if test="@streams and not(@streams='')">
        <xsl:variable name="q" select="translate(@streams,' ','-')"/>
        <xsl:call-template name="units">
            <xsl:with-param name="u">stream</xsl:with-param>
            <xsl:with-param name="q" select="$q"/>
        </xsl:call-template>
        <xsl:text>. </xsl:text>
      </xsl:if>
      <xsl:if test="@writtenLines and not(@writtenLines='')">
        <xsl:value-of select="translate(@writtenLines,' ','-')"/>
        <xsl:text> written lines per page. </xsl:text>
      </xsl:if>
      <xsl:if test="@ruledLines and not(@ruledLines='')">
        <xsl:value-of select="translate(@ruledLines,' ','-')"/>
        <xsl:text> ruled lines per page. </xsl:text>
      </xsl:if>
      <xsl:apply-templates />
    </li>
</xsl:template>

<xsl:template match="x:handDesc">
    <tr>
      <th>Scribal Hands</th>
      <td><ul>
        <xsl:apply-templates select="x:handNote"/>
      </ul></td>
    </tr>
</xsl:template>
<xsl:template match="x:decoDesc">
    <tr>
      <th>Decorations &amp; Illustrations</th>
      <td><ul>
        <xsl:apply-templates select="x:decoNote"/>
      </ul></td>
    </tr>
</xsl:template>

<my:decotype>
    <my:entry key="decorative">decorative</my:entry>
    <my:entry key="diagram">diagram</my:entry>
    <my:entry key="doodle">doodle</my:entry>
    <my:entry key="drawing">drawing</my:entry>
    <my:entry key="painting">painting</my:entry>
    <my:entry key="table">table</my:entry>
</my:decotype>
<my:subtype>
    <my:entry key="beginning">beginning</my:entry>
    <my:entry key="cover">cover</my:entry>
    <my:entry key="detached">detached</my:entry>
    <my:entry key="end">end</my:entry>
    <my:entry key="flyleaf">flyleaf</my:entry>
    <my:entry key="guard-folio">guard folio</my:entry>
    <my:entry key="inserted">inserted</my:entry>
    <my:entry key="intertextual">intertextual</my:entry>
    <my:entry key="marginal">marginal</my:entry>
    <my:entry key="spine">spine</my:entry>
    <my:entry key="title-page">title page</my:entry>
</my:subtype>

<xsl:template match="x:decoNote">
  <li>  
    <xsl:element name="span">
        <xsl:attribute name="class">type</xsl:attribute>
        <xsl:variable name="type" select="@type"/>
        <xsl:value-of select="document('')/*/my:decotype/my:entry[@key=$type]"/>
        <xsl:if test="@subtype">
            <xsl:text> (</xsl:text>
            <xsl:variable name="subtype" select="@subtype"/>
            <xsl:call-template name="splitlist">
                <xsl:with-param name="list" select="@subtype"/>
                <xsl:with-param name="nocapitalize">true</xsl:with-param>
                <xsl:with-param name="map">my:subtype</xsl:with-param>
            </xsl:call-template>
            <xsl:text>)</xsl:text>
        </xsl:if>
    </xsl:element>
    <xsl:if test="normalize-space(.) != ''">
        <ul>
            <li>
                <xsl:apply-templates/>
            </li>
        </ul>
    </xsl:if>
  </li>
</xsl:template>
<xsl:template match="x:decoNote/x:desc">
    <xsl:element name="ul">
        <xsl:element name="li">
            <xsl:call-template name="lang"/>
            <xsl:apply-templates/>
        </xsl:element>
    </xsl:element>
</xsl:template>

<xsl:template name="splitlist">
    <xsl:param name="list"/>
    <xsl:param name="nocapitalize"/>
    <xsl:param name="mss" select="$list"/>
    <xsl:param name="map"/>

    <xsl:if test="string-length($mss)">
        <xsl:if test="not($mss=$list)">, </xsl:if>
        <xsl:variable name="splitted" select="substring-before(
                                    concat($mss,' '),
                                  ' ')"/>
        <xsl:variable name="liststr">
            <xsl:choose>
                <xsl:when test="$map">
                    <xsl:variable name="test" select="document('')/*/*[name() = $map]/my:entry[@key=$splitted]"/>
                    <xsl:choose>
                        <xsl:when test="$test"> <xsl:value-of select="$test"/> </xsl:when>
                        <xsl:otherwise> <xsl:value-of select="$splitted"/> </xsl:otherwise>
                    </xsl:choose>
               </xsl:when>
                <xsl:otherwise>
                <xsl:value-of select="$splitted"/>
                </xsl:otherwise>
            </xsl:choose>
        </xsl:variable>
        <xsl:choose>
            <xsl:when test="$nocapitalize = 'true'">
                <xsl:value-of select="$liststr"/>
            </xsl:when>
            <xsl:otherwise>
                <xsl:call-template name="capitalize">
                    <xsl:with-param name="str" select="$liststr"/>
                </xsl:call-template>
            </xsl:otherwise>
        </xsl:choose>
        <xsl:call-template name="splitlist">
            <xsl:with-param name="mss" select=
                "substring-after($mss, ' ')"/>
            <xsl:with-param name="nocapitalize" select="$nocapitalize"/>
            <xsl:with-param name="map" select="$map"/>
        </xsl:call-template>
    </xsl:if>
</xsl:template>

<xsl:template name="capitalize">
    <xsl:param name="str"/>
    <xsl:variable name="LowerCase" select="'abcdefghijklmnopqrstuvwxyz'"/>
    <xsl:variable name="UpperCase" select="'ABCDEFGHIJKLMNOPQRSTUVWXYZ'"/>
    <xsl:value-of select="translate(
      substring($str,1,1),
      $LowerCase,
      $UpperCase
      )"/>
    <xsl:value-of select="substring($str,2,string-length($str)-1)"/>
</xsl:template>

<my:scriptRef>
    <my:entry key="#tamilPulliNone">no puḷḷi</my:entry>
    <my:entry key="#tamilPulliSporadic">sporadic puḷḷi</my:entry>
    <my:entry key="#tamilPulliRegular">regular puḷḷi</my:entry>
    <my:entry key="#tamilRa">closed kāl</my:entry>
    <my:entry key="#tamilOE">long ō/ē (double-curled kompu)</my:entry>
    <my:entry key="#tamilRRa"> modern ṟa</my:entry>
    <my:entry key="#prsthamatra">pṛṣṭhamātrā</my:entry>
    <my:entry key="#vaba">ba not distinguished</my:entry>
    <my:entry key="#sthascha">stha written as scha</my:entry>
    <my:entry key="#bengaliRaBarBelow">ra with bar below</my:entry>
    <my:entry key="#bengaliRaCrossbar">ra with cross-bar</my:entry>
    <my:entry key="#bengaliRa">modern ra</my:entry>
    <my:entry key="#bengaliYa">modern ya</my:entry>
    <my:entry key="#valapalagilaka">valapalagilaka</my:entry>
    <my:entry key="#dotreph">dot reph</my:entry>
</my:scriptRef>

<my:media>
    <my:entry key="ink">ink</my:entry>
    <my:entry key="incised">incised</my:entry>
    <my:entry key="pencil">pencil</my:entry>
    <my:entry key="black">black</my:entry>
    <my:entry key="brown">brown</my:entry>
    <my:entry key="blue">blue</my:entry>
    <my:entry key="red">red</my:entry>
</my:media>

<xsl:template match="x:handNote">
  <xsl:variable name="script" select="@script"/>
  <xsl:element name="li">  
    <xsl:attribute name="class">record_scripts</xsl:attribute>
    <xsl:attribute name="data-script"><xsl:value-of select="$script"/></xsl:attribute>
    <xsl:call-template name="n-format"/>
    <xsl:text> (</xsl:text><xsl:value-of select="@scope"/><xsl:text>) </xsl:text>
    <xsl:apply-templates select="@scribeRef"/>
    
    <xsl:element name="ul">
        <xsl:element name="li">
            <xsl:call-template name="splitlist">    
                <xsl:with-param name="list" select="@script"/>
            </xsl:call-template>
            <xsl:text> script</xsl:text>
            
            <xsl:if test="@scriptRef and not(@scriptRef='')">
                <xsl:text>: </xsl:text>
                <xsl:call-template name="splitlist">
                    <xsl:with-param name="list" select="@scriptRef"/>
                    <xsl:with-param name="nocapitalize">true</xsl:with-param>
                    <xsl:with-param name="map">my:scriptRef</xsl:with-param>
                </xsl:call-template>
            </xsl:if>
            <xsl:text>.</xsl:text>

            <xsl:if test="@medium and not(@medium='')">
                <xsl:text> </xsl:text>
                <xsl:variable name="donelist">
                    <xsl:call-template name="splitlist">
                        <xsl:with-param name="list" select="@medium"/>
                        <xsl:with-param name="nocapitalize">true</xsl:with-param>
                        <xsl:with-param name="map">my:media</xsl:with-param>
                    </xsl:call-template>
                </xsl:variable>
                <xsl:call-template name="capitalize">
                    <xsl:with-param name="str" select="$donelist"/>
                </xsl:call-template>
                <xsl:text>.</xsl:text>
            </xsl:if>
        </xsl:element>
    </xsl:element>
    <xsl:apply-templates/>
  </xsl:element>
</xsl:template>

<my:scribes>
    <my:entry key="#ArielTitleScribe">Ariel's title scribe</my:entry>
    <my:entry key="#EdouardAriel">Edouard Ariel</my:entry>
    <my:entry key="#UmraosinghShergil">Umraosingh Sher-Gil</my:entry>
</my:scribes>

<xsl:template match="x:handNote/@scribeRef">
    <xsl:if test="not(. = '')">
        <xsl:variable name="scribe" select="."/>
        <xsl:value-of select="document('')/*/my:scribes/my:entry[@key=$scribe]"/>
        <xsl:text>. </xsl:text>
    </xsl:if>
</xsl:template>

<xsl:template match="x:handNote/x:p">
    <ul><li><xsl:apply-templates/></li></ul>
</xsl:template>

<xsl:template match="x:handNote/x:desc">
    <xsl:element name="ul">
        <xsl:element name="li">
            <xsl:call-template name="lang"/>
            <xsl:apply-templates/>
        </xsl:element>
    </xsl:element>
</xsl:template>

<xsl:template match="x:additions">
  <tr>
    <th>Paratexts</th>
    <td>
        <ul>
          <xsl:apply-templates />
        </ul>
    </td>
  </tr>
</xsl:template>
<xsl:template match="x:additions/x:p">
    <li><xsl:apply-templates /></li>
</xsl:template>

<my:additiontype>
    <my:entry key="chapter-heading">chapter heading</my:entry>
    <my:entry key="end-title">end title</my:entry>
    <my:entry key="heading">heading</my:entry>
    <my:entry key="intertitle">intertitle</my:entry>
    <my:entry key="register">register</my:entry>
    <my:entry key="running-title">running title</my:entry>
    <my:entry key="table-of-contents">table of contents</my:entry>
    <my:entry key="title">title</my:entry>
    <my:entry key="verse-beginning">verse beginning</my:entry>
    <my:entry key="correction">correction</my:entry>
    <my:entry key="gloss">gloss/commentary</my:entry>
    <my:entry key="commenting-note">text-related note</my:entry>
    <my:entry key="blessing">blessing/benediction</my:entry>
    <my:entry key="completion-statement">completion statement</my:entry>
    <my:entry key="dedication">dedication</my:entry>
    <my:entry key="invocation">invocation</my:entry>
    <my:entry key="postface">postface</my:entry>
    <my:entry key="preface">preface</my:entry>
    <my:entry key="satellite-stanza">satellite stanza</my:entry>
    <my:entry key="seal">seal</my:entry>
    <my:entry key="shelfmark">shelfmark</my:entry>
    <my:entry key="stamp">stamp</my:entry>
    <my:entry key="documenting-note">user-related note</my:entry>
</my:additiontype>

<xsl:template match="x:additions/x:desc">
    <li> 
        <xsl:element name="span">
            <xsl:attribute name="class">type</xsl:attribute>
            <xsl:variable name="type" select="@type"/>
            <xsl:if test="@type">
                <xsl:call-template name="splitlist">
                        <xsl:with-param name="list" select="@type"/>
                        <xsl:with-param name="nocapitalize">true</xsl:with-param>
                        <xsl:with-param name="map">my:additiontype</xsl:with-param>
                </xsl:call-template>
            </xsl:if>
            <xsl:if test="@subtype">
                <xsl:text> (</xsl:text>
                <xsl:call-template name="splitlist">
                    <xsl:with-param name="list" select="@subtype"/>
                    <xsl:with-param name="nocapitalize">true</xsl:with-param>
                    <xsl:with-param name="map">my:subtype</xsl:with-param>
                </xsl:call-template>
                <xsl:text>)</xsl:text>
            </xsl:if>
        </xsl:element>
        <xsl:if test="normalize-space(.) != ''">
            <ul>
                <li>
                    <xsl:apply-templates/>
                </li>
            </ul>
        </xsl:if>
    </li>
</xsl:template>

<xsl:template match="x:bindingDesc">
    <tr>
        <th>Binding</th>
        <td>
            <xsl:apply-templates/>
        </td>
    </tr>
</xsl:template>

<xsl:template match="x:binding">
    <p><xsl:apply-templates/></p>
</xsl:template>
<xsl:template match="x:binding/x:p">
    <xsl:apply-templates/>
</xsl:template>

<xsl:template match="x:history">
    <section>
    <h3>History</h3>
    <table id="history">
        <tr>
            <th>Date of production</th>
            <td><xsl:apply-templates select="x:origin/x:origDate"/></td>
        </tr>
        <tr>
            <th>Place of origin</th>
            <td><xsl:apply-templates select="x:origin/x:origPlace"/></td>
        </tr>
        <xsl:if test="x:provenance">
            <tr>
                <th>Provenance</th>
                <td><xsl:apply-templates select="x:provenance"/></td>
            </tr>
        </xsl:if>
        <xsl:if test="x:acquisition">
            <tr>
                <th>Acquisition</th>
                <td><xsl:apply-templates select="x:acquisition"/></td>
            </tr>
        </xsl:if>
    </table>
    </section>
</xsl:template>

<xsl:template match="x:listBibl">
    <h3>Bibliography</h3>
    <xsl:apply-templates/>
</xsl:template>
<xsl:template match="x:bibl">
    <xsl:element name="p">
        <xsl:attribute name="class">bibliography</xsl:attribute>
        <xsl:apply-templates/>
    </xsl:element>
</xsl:template>

<xsl:template match="x:emph">
    <xsl:element name="em">
        <xsl:attribute name="class">
            <xsl:value-of select="@rend"/>
        </xsl:attribute>
        <xsl:call-template name="lang"/>
        <xsl:apply-templates/>
    </xsl:element>
</xsl:template>

<xsl:template match="x:lg">
    <xsl:element name="div">
        <xsl:attribute name="class">lg</xsl:attribute>
        <xsl:call-template name="lang"/>
        <xsl:apply-templates/>
    </xsl:element>
</xsl:template>

<xsl:template match="x:l">
    <xsl:element name="div">
        <xsl:call-template name="lang"/>
        <xsl:attribute name="class">l</xsl:attribute>
        <xsl:apply-templates/>
    </xsl:element>
</xsl:template>

<xsl:template match="x:additional">
    <xsl:apply-templates/>
</xsl:template>

<xsl:template match="x:encodingDesc">
    <h3>Encoding conventions</h3>
    <xsl:apply-templates/>
</xsl:template>

<xsl:template match="x:profileDesc"/>

<xsl:template match="x:revisionDesc">
    <section>
        <h3>Revision history</h3>
        <xsl:element name="table">
            <xsl:apply-templates/>
        </xsl:element>
    </section>
</xsl:template>

<xsl:template match="x:revisionDesc/x:change">
    <xsl:element name="tr">
        <xsl:element name="th">
            <xsl:attribute name="class">when</xsl:attribute>
            <xsl:value-of select="@when"/>
        </xsl:element>
        <xsl:element name="td">
            <xsl:apply-templates/>
        </xsl:element>
    </xsl:element>
</xsl:template>

<xsl:template match="x:facsimile"/>

<xsl:template match="x:text">
    <xsl:element name="hr">
        <xsl:attribute name="id">
            <xsl:text>text-</xsl:text>
            <xsl:value-of select="@n"/>
        </xsl:attribute>
    </xsl:element>
    <xsl:element name="section">
        <xsl:attribute name="class">teitext</xsl:attribute>
        <xsl:call-template name="lang"/>
        <xsl:apply-templates select="@n"/>
        <xsl:apply-templates/>
    </xsl:element>
</xsl:template>

<xsl:template match="x:text/@n">
    <xsl:element name="h2">
        <xsl:attribute name="lang">en</xsl:attribute>
        <xsl:value-of select="."/>
    </xsl:element>
</xsl:template>

<xsl:template match="x:text/x:body">
    <xsl:apply-templates/>
</xsl:template>

<xsl:template match="x:ref">
    <xsl:element name="a">
        <xsl:attribute name="href"><xsl:value-of select="@target"/></xsl:attribute>
        <xsl:apply-templates/>
    </xsl:element>
</xsl:template>

<xsl:template match="x:p">
    <xsl:element name="p">
        <xsl:call-template name="lang"/>
        <xsl:apply-templates/>
    </xsl:element>
</xsl:template>

<xsl:template match="x:material">
    <xsl:element name="span">
        <xsl:attribute name="class">material</xsl:attribute>
        <xsl:apply-templates/>
    </xsl:element>
</xsl:template>

<xsl:template match="x:persName">
    <xsl:element name="span">
        <xsl:attribute name="class">persname</xsl:attribute>
        <xsl:call-template name="lang"/>
        <xsl:apply-templates/>
    </xsl:element>
</xsl:template>

<xsl:template match="x:geogName">
    <xsl:element name="span">
        <xsl:attribute name="class">geogname</xsl:attribute>
        <xsl:call-template name="lang"/>
        <xsl:apply-templates/>
    </xsl:element>
</xsl:template>

<xsl:template match="x:sourceDoc"/>

<!-- transcription styling -->

<xsl:template match="x:del">
    <xsl:variable name="rend" select="@rend"/>
    <xsl:element name="del">
        <xsl:attribute name="data-anno">
            <xsl:text>deleted</xsl:text>
            <xsl:if test="string($rend)">
                <xsl:text> (</xsl:text>
                <xsl:value-of select="$rend"/>
                <xsl:text>)</xsl:text>
           </xsl:if>
        </xsl:attribute>
        <xsl:apply-templates/>
    </xsl:element>
</xsl:template>

<xsl:template match="x:add">
    <xsl:element name="ins">
        <xsl:attribute name="class">add</xsl:attribute>
        <xsl:attribute name="data-anno">
            <xsl:text>inserted</xsl:text>
            <xsl:if test="@place"> (<xsl:value-of select="@place"/>)</xsl:if>
            <xsl:if test="@rend"> (<xsl:value-of select="@rend"/>)</xsl:if>
        </xsl:attribute>
        <xsl:apply-templates />
    </xsl:element>
</xsl:template>

<xsl:template match="x:subst">
    <xsl:element name="span">
    <xsl:attribute name="class">subst</xsl:attribute>
    <xsl:attribute name="data-anno">
        <xsl:text>substitution</xsl:text>
        <xsl:if test="@rend">
            <xsl:text> (</xsl:text><xsl:value-of select="@rend"/><xsl:text>)</xsl:text>
        </xsl:if>
    </xsl:attribute>
    <xsl:apply-templates />
    </xsl:element>
</xsl:template>

<xsl:template match="x:supplied">
    <xsl:element name="span">
        <xsl:attribute name="class">supplied</xsl:attribute>
        <xsl:attribute name="data-anno">
            <xsl:text>supplied</xsl:text>
            <xsl:if test="@reason">
                <xsl:text> (</xsl:text><xsl:value-of select="@reason"/><xsl:text>)</xsl:text>
            </xsl:if>
        </xsl:attribute>
        <xsl:apply-templates />
    </xsl:element>
</xsl:template>

<xsl:template match="x:pc">
    <xsl:element name="span">
        <xsl:attribute name="class">invisible</xsl:attribute>
        <xsl:apply-templates/>
    </xsl:element>
</xsl:template>

<xsl:template match="x:sic">
    <xsl:element name="span">
        <xsl:attribute name="class">sic</xsl:attribute>
        <xsl:call-template name="lang"/>
        <xsl:attribute name="data-anno">sic</xsl:attribute>
        <xsl:apply-templates/>
    </xsl:element>
</xsl:template>

<xsl:template match="x:gap">
    <xsl:element name="span">
        <xsl:attribute name="lang">en</xsl:attribute>
        <xsl:attribute name="class">gap</xsl:attribute>
        <xsl:attribute name="data-anno">
            <xsl:text>gap</xsl:text>
                <xsl:choose>
                    <xsl:when test="@quantity">
                        <xsl:text> of </xsl:text><xsl:value-of select="@quantity"/>
                        <xsl:choose>
                        <xsl:when test="@unit">
                        <xsl:text> </xsl:text><xsl:value-of select="@unit"/>
                        </xsl:when>
                        <xsl:otherwise>
                        <xsl:text> akṣara</xsl:text>
                        </xsl:otherwise>
                        </xsl:choose>
                            <xsl:if test="@quantity &gt; '1'">
                                <xsl:text>s</xsl:text>
                            </xsl:if>
                    </xsl:when>
                    <xsl:when test="@extent">
                        <xsl:text> of </xsl:text><xsl:value-of select="@extent"/>
                    </xsl:when>
                </xsl:choose>
                <xsl:if test="@reason">
                    <xsl:text> (</xsl:text><xsl:value-of select="@reason"/><xsl:text>)</xsl:text>
                </xsl:if>
        </xsl:attribute>
        <xsl:choose>
            <xsl:when test="count(./*) &gt; 0">
                <xsl:text>[</xsl:text>
                <xsl:apply-templates/>
                <xsl:text>]</xsl:text>
            </xsl:when>
            <xsl:otherwise>
                <xsl:element name="span">
                <xsl:text>...</xsl:text>
                <xsl:choose>
                    <xsl:when test="@quantity &gt; 1">
                        <xsl:call-template name="repeat">
                            <xsl:with-param name="output"><xsl:text>..</xsl:text></xsl:with-param>
                            <xsl:with-param name="count" select="@quantity"/>
                        </xsl:call-template>

                    </xsl:when>
                    <xsl:when test="@extent">
                        <xsl:variable name="extentnum" select="translate(@extent,translate(@extent,'0123456789',''),'')"/>
                        <xsl:if test="number($extentnum) &gt; 1">
                            <xsl:call-template name="repeat">
                                <xsl:with-param name="output"><xsl:text>..</xsl:text></xsl:with-param>
                                <xsl:with-param name="count" select="$extentnum"/>
                            </xsl:call-template>
                        </xsl:if>
                    </xsl:when>
                </xsl:choose>
                </xsl:element>
            </xsl:otherwise>
        </xsl:choose>
    </xsl:element>
</xsl:template>

<xsl:template match="x:space">
    <xsl:element name="span">
        <xsl:attribute name="lang">en</xsl:attribute>
        <xsl:attribute name="class">space</xsl:attribute>
        <xsl:attribute name="data-anno">
            <xsl:text>space</xsl:text>
            <xsl:if test="@quantity">
                <xsl:text> of </xsl:text><xsl:value-of select="@quantity"/>
                <xsl:choose>
                <xsl:when test="@unit">
                <xsl:text> </xsl:text><xsl:value-of select="@unit"/>
                    <xsl:if test="@quantity &gt; '1'">
                        <xsl:text>s</xsl:text>
                    </xsl:if>
                </xsl:when>
                <xsl:otherwise>
                <xsl:text> akṣara</xsl:text>
                    <xsl:if test="@quantity &gt; '1'">
                        <xsl:text>s</xsl:text>
                    </xsl:if>
                </xsl:otherwise>
                </xsl:choose>
            </xsl:if>
            <xsl:if test="@rend">
                <xsl:text> (</xsl:text><xsl:value-of select="@rend"/><xsl:text>)</xsl:text>
            </xsl:if>
        </xsl:attribute>
        <xsl:choose>
            <xsl:when test="count(./*) &gt; 0">
                <xsl:apply-templates/>
            </xsl:when>
            <xsl:otherwise>
                <xsl:element name="span">
                <xsl:text>_</xsl:text>
                <xsl:choose>
                    <xsl:when test="@quantity &gt; 1">
                        <xsl:call-template name="repeat">
                            <xsl:with-param name="output"><xsl:text>_&#x200B;</xsl:text></xsl:with-param>
                            <xsl:with-param name="count" select="@quantity"/>
                        </xsl:call-template>

                    </xsl:when>
                    <xsl:when test="@extent">
                        <xsl:variable name="extentnum" select="translate(@extent,translate(@extent,'0123456789',''),'')"/>
                        <xsl:if test="number($extentnum) &gt; 1">
                            <xsl:call-template name="repeat">
                                <xsl:with-param name="output"><xsl:text>_&#x200B;</xsl:text></xsl:with-param>
                                <xsl:with-param name="count" select="$extentnum"/>
                            </xsl:call-template>
                        </xsl:if>
                    </xsl:when>
                </xsl:choose>
                </xsl:element>
            </xsl:otherwise>
        </xsl:choose>
    </xsl:element>
</xsl:template>

<my:entities>
    <my:entry key="#pcs">&#x0BF3;</my:entry>
    <my:entry key="#maatham">௴</my:entry>
    <my:entry key="#varudam">௵</my:entry>
    <my:entry key="#patru">௶</my:entry>
    <my:entry key="#eduppu">௷</my:entry>
    <my:entry key="#merpadi">௸</my:entry>
    <my:entry key="#rupai">௹</my:entry>
    <my:entry key="#niluvai">௺</my:entry>
    <my:entry key="#munthiri">𑿀</my:entry>
    <my:entry key="#araikkaani">𑿁</my:entry>
    <my:entry key="#kaani">𑿂</my:entry>
    <my:entry key="#kaal_viisam">𑿃</my:entry>
    <my:entry key="#arai_maa">𑿄</my:entry>
    <my:entry key="#arai_viisam">𑿅</my:entry>
    <my:entry key="#mukkaani">𑿆</my:entry>
    <my:entry key="#mukkaal_viisam">𑿇</my:entry>
    <my:entry key="#maa">𑿈</my:entry>
    <my:entry key="#viisam">𑿉</my:entry>
    <my:entry key="#viisam_alt">𑿊</my:entry>
    <my:entry key="#irumaa">𑿋</my:entry>
    <my:entry key="#araikkaal">𑿌</my:entry>
    <my:entry key="#mumaa">𑿍</my:entry>
    <my:entry key="#muuviisam">𑿎</my:entry>
    <my:entry key="#naangu_maa">𑿏</my:entry>
    <my:entry key="#kaal">𑿐</my:entry>
    <my:entry key="#arai">𑿑</my:entry>
    <my:entry key="#arai_alt">𑿒</my:entry>
    <my:entry key="#mukkaal">𑿓</my:entry>
    <my:entry key="#kiizh">𑿔</my:entry>
    <my:entry key="#nel">𑿕</my:entry>
    <my:entry key="#cevitu">𑿖</my:entry>
    <my:entry key="#aazhaakku">𑿗</my:entry>
    <my:entry key="#uzhakku">𑿘</my:entry>
    <my:entry key="#muuvuzhakku">𑿙</my:entry>
    <my:entry key="#kuruni">𑿚</my:entry>
    <my:entry key="#pathakku">𑿛</my:entry>
    <my:entry key="#mukkuruni">𑿜</my:entry>
    <my:entry key="#kaacu">𑿝</my:entry>
    <my:entry key="#panam">𑿞</my:entry>
    <my:entry key="#pon">𑿟</my:entry>
    <my:entry key="#varaakan">𑿠</my:entry>
    <my:entry key="#paaram">𑿡</my:entry>
    <my:entry key="#kuzhi">𑿢</my:entry>
    <my:entry key="#veli">𑿣</my:entry>
    <my:entry key="#nansey">𑿤</my:entry>
    <my:entry key="#punsey">𑿥</my:entry>
    <my:entry key="#nilam">𑿦</my:entry>
    <my:entry key="#uppalam">𑿧</my:entry>
    <my:entry key="#varavu">𑿨</my:entry>
    <my:entry key="#enn">𑿩</my:entry>
    <my:entry key="#naalathu">𑿪</my:entry>
    <my:entry key="#silvaanam">𑿫</my:entry>
    <my:entry key="#poga">𑿬</my:entry>
    <my:entry key="#aaga">𑿭</my:entry>
    <my:entry key="#vasam">𑿮</my:entry>
    <my:entry key="#muthal">𑿯</my:entry>
    <my:entry key="#muthaliya">𑿰</my:entry>
    <my:entry key="#vakaiyaraa">𑿱</my:entry>
    <my:entry key="#end_of_text">𑿿</my:entry>
</my:entities>
<my:entitynames>
    <my:entry key="#pcs">piḷḷaiyār cuḻi (short)</my:entry>
    <my:entry key="#maatham">month</my:entry>
    <my:entry key="#varudam">year</my:entry>
    <my:entry key="#patru">debit</my:entry>
    <my:entry key="#eduppu">credit</my:entry>
    <my:entry key="#merpadi">as above</my:entry>
    <my:entry key="#rupai">rupee</my:entry>
    <my:entry key="#niluvai">balance</my:entry>
    <my:entry key="#munthiri">1/320</my:entry>
    <my:entry key="araikkaani">1/160</my:entry>
    <my:entry key="#kaani">1/80</my:entry>
    <my:entry key="#kaal_viisam">1/64</my:entry>
    <my:entry key="#arai_maa">1/40</my:entry>
    <my:entry key="#arai_viisam">1/32</my:entry>
    <my:entry key="#mukkaal_viisam">3/64</my:entry>
    <my:entry key="#mukkaani">3/80</my:entry>
    <my:entry key="#maa">1/20</my:entry>
    <my:entry key="#viisam">1/16</my:entry>
    <my:entry key="#viisam_alt">1/16</my:entry>
    <my:entry key="#irumaa">1/10</my:entry>
    <my:entry key="#araikkaal">1/8</my:entry>
    <my:entry key="#mumaa">3/20</my:entry>
    <my:entry key="#muuviisam">3/16</my:entry>
    <my:entry key="#naangu_maa">1/5</my:entry>
    <my:entry key="#kaal">1/4</my:entry>
    <my:entry key="#arai">1/2</my:entry>
    <my:entry key="#arai_alt">1/2</my:entry>
    <my:entry key="#mukkaal">3/4</my:entry>
    <my:entry key="#kiizh">less 1/320</my:entry>
    <my:entry key="#nel">nel</my:entry>
    <my:entry key="#cevitu">cevitu</my:entry>
    <my:entry key="#aazhaakku">āḻākku</my:entry>
    <my:entry key="#uzhakku">uḻakku</my:entry>
    <my:entry key="#muuvuzhakku">mūvuḻakku</my:entry>
    <my:entry key="#kuruni">kuṟuṇi</my:entry>
    <my:entry key="#pathakku">patakku</my:entry>
    <my:entry key="#mukkuruni">mukkuṟuṇi</my:entry>
    <my:entry key="#kaacu">kācu</my:entry>
    <my:entry key="#panam">paṇam</my:entry>
    <my:entry key="#pon">poṉ</my:entry>
    <my:entry key="#varaakan">varākaṉ</my:entry>
    <my:entry key="#paaram">pāram</my:entry>
    <my:entry key="#kuzhi">kuḻi</my:entry>
    <my:entry key="#veli">vēļi</my:entry>
    <my:entry key="#nansey">wet cultivation</my:entry>
    <my:entry key="#nilam">land</my:entry>
    <my:entry key="#uppalam">salt pan</my:entry>
    <my:entry key="#varavu">credit</my:entry>
    <my:entry key="#enn">number</my:entry>
    <my:entry key="#naalathu">current</my:entry>
    <my:entry key="#silvaanam">and odd</my:entry>
    <my:entry key="#poga">spent</my:entry>
    <my:entry key="#aaga">total</my:entry>
    <my:entry key="#vasam">in possession</my:entry>
    <my:entry key="#muthal">starting from</my:entry>
    <my:entry key="#muthaliya">et cetera (in a series)</my:entry>
    <my:entry key="#vakaiyaraa">et cetera (of a kind)</my:entry>
    <my:entry key="#end_of_text">end of text</my:entry>
</my:entitynames>

<xsl:template match="x:g">
        <xsl:element name="span">
            <xsl:attribute name="class">gaiji</xsl:attribute>
            <xsl:variable name="ref" select="@ref"/>
            <xsl:variable name="ename" select="document('')/*/my:entitynames/my:entry[@key=$ref]"/>
            <xsl:if test="$ename">
                <xsl:attribute name="data-anno"><xsl:value-of select="$ename"/></xsl:attribute>
            </xsl:if>
            <xsl:variable name="txt" select="document('')/*/my:entities/my:entry[@key=$ref]"/>

            <xsl:if test="$txt">
                <xsl:value-of select="$txt"/>
            </xsl:if>
        </xsl:element>
</xsl:template>
<xsl:template match="x:g[@ref='#pcl']">
        <xsl:element name="span">
            <xsl:attribute name="class">gaiji aalt</xsl:attribute>
            <xsl:attribute name="data-anno">piḷḷaiyār cuḻi (long)</xsl:attribute>
            <!--xsl:text>&#xF8FF;</xsl:text-->
            <xsl:text>&#x0BF3;</xsl:text>
        </xsl:element>
</xsl:template>
<xsl:template match="x:g[@ref='#kompu']">
        <xsl:element name="span">
            <xsl:attribute name="class">gaiji aalt</xsl:attribute>
            <xsl:attribute name="data-anno">kompu</xsl:attribute>
            <xsl:text>&#x0B8E;</xsl:text>
        </xsl:element>
</xsl:template>
<xsl:template match="x:g[@ref='#ra_r_kal']">
        <xsl:element name="span">
            <xsl:attribute name="class">gaiji aalt</xsl:attribute>
            <xsl:attribute name="data-anno">ra, r, or kāl</xsl:attribute>
            <xsl:text>&#xB86;</xsl:text>
        </xsl:element>
</xsl:template>
<xsl:template match="x:g[@ref='#nna=m']">
        <xsl:element name="span">
            <xsl:attribute name="class">gaiji alig</xsl:attribute>
            <xsl:attribute name="data-anno">ṇam ligature</xsl:attribute>
            <xsl:if test="not(node())">
                <xsl:text>&#xBA3;&#xBAE;&#xBCD;</xsl:text>
            </xsl:if>
            <xsl:apply-templates/>
        </xsl:element>
</xsl:template>
<xsl:template match="x:g[@ref='#ya=m']">
        <xsl:element name="span">
            <xsl:attribute name="class">gaiji alig</xsl:attribute>
            <xsl:attribute name="data-anno">yam ligature</xsl:attribute>
            <xsl:if test="not(node())">
                <xsl:text>&#xBAF;&#xBAE;&#xBCD;</xsl:text>
            </xsl:if>
            <xsl:apply-templates/>
        </xsl:element>
</xsl:template>
<xsl:template match="x:div1">
    <xsl:element name="section">
        <xsl:apply-templates/>
    </xsl:element>
</xsl:template>
<xsl:template match="x:div2">
    <xsl:element name="section">
        <xsl:apply-templates/>
    </xsl:element>
</xsl:template>
<xsl:template match="x:div3">
    <xsl:element name="section">
        <xsl:apply-templates/>
    </xsl:element>
</xsl:template>

<xsl:template match="x:div1/x:head">
    <xsl:element name="h2">
        <xsl:apply-templates/>
    </xsl:element>
</xsl:template>
<xsl:template match="x:div2/x:head">
    <xsl:element name="h3">
        <xsl:apply-templates/>
    </xsl:element>
</xsl:template>
<xsl:template match="x:div3/x:head">
    <xsl:element name="h4">
        <xsl:apply-templates/>
    </xsl:element>
</xsl:template>

<xsl:template match="x:list">
    <xsl:element name="ul">
        <xsl:call-template name="lang"/>
        <xsl:apply-templates/>
    </xsl:element>
</xsl:template>
<xsl:template match="x:list[@rend='numbered']">
    <xsl:element name="ol">
        <xsl:apply-templates/>
    </xsl:element>
</xsl:template>
<xsl:template match="x:item">
    <xsl:element name="li">
        <xsl:apply-templates/>
    </xsl:element>
</xsl:template>

<xsl:template match="x:unclear">
    <xsl:element name="span">
        <xsl:attribute name="class">unclear</xsl:attribute>
        <xsl:attribute name="data-anno">
            <xsl:text>unclear</xsl:text>
            <xsl:if test="@reason">
                <xsl:text> (</xsl:text>
                <xsl:value-of select="@reason"/>
                <xsl:text>)</xsl:text>
            </xsl:if>
        </xsl:attribute>
        <xsl:apply-templates/>
    </xsl:element>
</xsl:template>

<xsl:template match="x:interp">
    <xsl:element name="span">
        <xsl:attribute name="class">interp</xsl:attribute>
        <xsl:attribute name="data-anno">
            <xsl:value-of select="@type"/>
        </xsl:attribute>
    </xsl:element>
</xsl:template>

<xsl:template match="x:caesura">
<xsl:variable name="pretext" select="preceding::text()[1]"/>
<xsl:if test="normalize-space(substring($pretext,string-length($pretext))) != ''">
    <span class="caesura">-</span>
</xsl:if>
    <xsl:element name="br">
    <xsl:attribute name="class">caesura</xsl:attribute>
    </xsl:element>
</xsl:template>

<xsl:template match="x:expan">
    <xsl:element name="span">
        <xsl:call-template name="lang"/>
        <xsl:attribute name="class">expan</xsl:attribute>
        <xsl:attribute name="data-anno">abbreviation</xsl:attribute>
        <xsl:apply-templates/>
    </xsl:element>
</xsl:template>

<xsl:template match="x:ex">
    <xsl:element name="span">
        <xsl:call-template name="lang"/>
        <xsl:attribute name="class">ex</xsl:attribute>
        <xsl:attribute name="data-anno">editorial expansion</xsl:attribute>
        <xsl:apply-templates/>
    </xsl:element>
</xsl:template>

<xsl:template match="x:note">
<xsl:element name="span">
    <xsl:call-template name="lang"/>
    <xsl:attribute name="class">note
        <xsl:choose>
            <xsl:when test="@place='above' or @place='top-margin' or @place='left-margin'"> super</xsl:when>
            <xsl:when test="@place='below' or @place='bottom-margin' or @place='right-margin'"> sub</xsl:when>
            <xsl:otherwise> inline</xsl:otherwise>
        </xsl:choose>
    </xsl:attribute>
    <xsl:attribute name="data-anno">note
        <xsl:if test="@place"> (<xsl:value-of select="@place"/>)</xsl:if>
        <xsl:if test="@resp"> (by <xsl:value-of select="@resp"/>)</xsl:if>
    </xsl:attribute>
    <xsl:apply-templates />
</xsl:element>
</xsl:template>

<xsl:template match="@*|node()">
    <xsl:copy>
    <xsl:apply-templates select="@*|node()"/>
    </xsl:copy>
</xsl:template>

</xsl:stylesheet>
