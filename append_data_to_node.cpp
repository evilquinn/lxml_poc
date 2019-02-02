
#include <fstream>
#include <vector>
#include <libxml/parser.h>
#include <libxml/tree.h>

int main(int argc, char* argv[])
{
    LIBXML_TEST_VERSION;

    auto doc = xmlNewDoc(BAD_CAST "1.0");
    auto root_node = xmlNewNode(NULL, BAD_CAST "root");
    xmlDocSetRootElement(doc, root_node);
    auto data_node = xmlNewChild(root_node, NULL, BAD_CAST "data", NULL);

    std::ifstream file_in("/home/evilquinn/git/lxml_poc/small_file.txt");
    for ( std::string line; std::getline(file_in, line); )
    {
        line.push_back('\n');
        xmlNodeAddContent(data_node, BAD_CAST line.c_str());
    }

    std::vector<uint8_t> binary_data;
    for ( uint8_t i = 0; i < 255; ++i )
    {
        binary_data.push_back(i+1);
    }
    binary_data.push_back(0);
    xmlNodeAddContent(data_node, BAD_CAST binary_data.data());

    xmlSaveFormatFileEnc("-", doc, "UTF-8", 1);
    xmlFreeDoc(doc);
    xmlCleanupParser();

    return(0);
}
