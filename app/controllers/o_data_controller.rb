class ODataController < ApplicationController
  
  def index
    odata_crap = "<service xmlns=\"http://www.w3.org/2007/app\" xmlns:atom=\"http://www.w3.org/2005/Atom\" xmlns:m=\"http://docs.oasis-open.org/odata/ns/metadata\" xml:base=\"http://192.168.1.10:3001/OData.svc/\" m:context=\"http://192.168.1.10:3001/OData.svc/$metadata\">
      <workspace>
        <atom:title type=\"text\">Default</atom:title>
        <collection href=\"Products\">
          <atom:title type=\"text\">Products</atom:title>
        </collection>
      </workspace>
    </service>"
    render xml: odata_crap
  end

  def products
    products_xml = "<?xml version=\"1.0\" encoding=\"utf-8\"?><feed xml:base=\"http://192.168.1.10:3001/OData.svc/\" xmlns=\"http://www.w3.org/2005/Atom\" xmlns:d=\"http://schemas.microsoft.com/ado/2007/08/dataservices\" xmlns:m=\"http://schemas.microsoft.com/ado/2007/08/dataservices/metadata\" xmlns:georss=\"http://www.georss.org/georss\" xmlns:gml=\"http://www.opengis.net/gml\"><id>http://192.168.1.10:3001/OData.svc/Products</id><title type=\"text\">Products</title>"
    products_xml += "<updated>2014-07-11T20:39:16Z</updated>"
    products_xml += "<link rel=\"self\" title=\"Products\" href=\"Products\" />"
    products_xml += "<entry>"
    products_xml += "<id>http://192.168.1.10:3001/OData.svc/Products(0)</id>"
    products_xml += "<category term=\"ODataDemo.Product\" scheme=\"http://schemas.microsoft.com/ado/2007/08/dataservices/scheme\" />"
    products_xml += "<title type=\"text\">Bread</title>"
    products_xml += "<summary type=\"text\">Whole grain bread</summary>"
    products_xml += "<updated>2014-07-11T20:39:16Z</updated>"
    products_xml += "<author><name /></author><content type=\"application/xml\">"
    products_xml += "<m:properties><d:ID m:type=\"Edm.Int32\">0</d:ID>"
    products_xml += "<d:ReleaseDate m:type=\"Edm.DateTime\">1992-01-01T00:00:00</d:ReleaseDate>"
    products_xml += "<d:DiscontinuedDate m:null=\"true\" /><d:Rating m:type=\"Edm.Int16\">4</d:Rating>"
    products_xml += "<d:Price m:type=\"Edm.Double\">2.5</d:Price></m:properties></content>"
    products_xml += "</entry></feed>"
    render xml: products_xml, content_type: 'application/atom+xml;type=feed;charset=utf-8'
  end

  def odata_query
    case params[:odata_param]
      when '$metadata'
      odata_metadata = "<edmx:Edmx xmlns:edmx=\"http://docs.oasis-open.org/odata/ns/edmx\" Version=\"4.0\">
      <edmx:DataServices>
        <Schema xmlns=\"http://docs.oasis-open.org/odata/ns/edm\" Namespace=\"ODataDemo\">
          <EntityType Name=\"Product\">
            <Key>
              <PropertyRef Name=\"ID\"/>
            </Key>
            <Property Name=\"ID\" Type=\"Edm.Int32\" Nullable=\"false\"/>
            <Property Name=\"Name\" Type=\"Edm.String\"/>
            <Property Name=\"Description\" Type=\"Edm.String\"/>
            <Property Name=\"ReleaseDate\" Type=\"Edm.DateTimeOffset\" Nullable=\"false\"/>
            <Property Name=\"DiscontinuedDate\" Type=\"Edm.DateTimeOffset\"/>
            <Property Name=\"Rating\" Type=\"Edm.Int16\" Nullable=\"false\"/>
            <Property Name=\"Price\" Type=\"Edm.Double\" Nullable=\"false\"/>
          </EntityType>
          <EntityContainer Name=\"DemoService\">
            <EntitySet Name=\"Products\" EntityType=\"ODataDemo.Product\"/>
          </EntityContainer>
          <Annotations Target=\"ODataDemo.DemoService\">
            <Annotation Term=\"Org.OData.Display.V1.Description\" String=\"This is a sample OData service with vocabularies\"/>
          </Annotations>
          <Annotations Target=\"ODataDemo.Product\">
            <Annotation Term=\"Org.OData.Display.V1.Description\" String=\"All Products available in the online store\"/>
          </Annotations>
          <Annotations Target=\"ODataDemo.Product/Name\">
            <Annotation Term=\"Org.OData.Display.V1.DisplayName\" String=\"Product Name\"/>
          </Annotations>
        </Schema>
      </edmx:DataServices>
    </edmx:Edmx>"
    render xml: odata_metadata
    when 'Products'
      products
    end
  end

end
