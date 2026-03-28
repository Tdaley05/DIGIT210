<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:xs="http://www.w3.org/2001/XMLSchema"
    xmlns:math="http://www.w3.org/2005/xpath-functions/math"
    xmlns="http://www.w3.org/2000/svg"
    exclude-result-prefixes="xs math"
    version="3.0">
    <!-- ebb: This XSLT is designed to output SVG from information in an XML file.
        We need the SVG namespace to control the output in the XSLT root element:
        see the xmlns="http://www.w3.org/2000/svg" 
        
        The XSLT is reading in XML that has no namespace. 
        (If you are reading from XML in a namespace such as TEI,
        use the xpath-default-namespace="..." to apply it.) 
    -->
    <xsl:output method="xml" indent="yes"/>
    <xsl:variable name="xSpacing" select="200"/>
    <xsl:variable name="scale" select="40"/>
    
    <xsl:template match="/">
        <svg width="900" height="700">
            
            <text x="450" y="50" text-anchor="middle"
                font-size="28" font-weight="bold">
                Magic Egg Count by Blob
            </text>
            
            <text x="700" y="150" fill="black" font-size="16">
                Legend: Circle size &amp; color = number of Magic Eggs
            </text>
            
            <g transform="translate(0,600)">
                
            <line x1="100" y1="600" x2="850" y2="600"
                stroke="black" stroke-width="3"/>
            <line x1="100" y1="600" x2="100" y2="100"
                stroke="black" stroke-width="3"/>
            
            <text x="40" y="350"
                transform="rotate(-90 40,350)"
                font-size="18">
                Magic Egg Count
            </text>
            
            <text x="450" y="660"
                text-anchor="middle"
                font-size="18">
                Blobs
            </text>
            </g>
            <g transform="translate(0,600)">
                
                <xsl:for-each select="xml/blob">
                    
                    <xsl:variable name="eggs"
                        select="count(.//special[@whatsIt='magicEgg'])"/>
                    
                    <xsl:variable name="x"
                        select="100 + position() * $xSpacing"/>
                    
                    <xsl:variable name="y"
                        select="- $eggs * $scale"/>
                    <!-- not sure with some of this, but it seemed to not give any errors? -->
                    <circle
                        cx="{$x}"
                        cy="{$y}"
                        r="{$eggs * 8}"
                        fill="rgb({$eggs * 60},0,150)"
                        stroke="black"
                        stroke-width="2"/>
                    
                    <text x="{$x}" y="30"
                        text-anchor="middle"
                        font-size="14">
                        <xsl:value-of select="heading"/>
                    </text>
                    <!-- didn't turn out exactly how I wanted but I'll see about fixing it, unless I mis interpreted what I planned -->
                </xsl:for-each>
                
            </g>
            
        </svg>
    </xsl:template>
    
</xsl:stylesheet>