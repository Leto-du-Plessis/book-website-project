from pdfminer.high_level import extract_text
from pathlib import Path
import json
import uuid 

backend_dir = Path(__file__).resolve().parent
test_data_directory = backend_dir.parent / 'test_data'

class PdfToJsonConverter: 

    @staticmethod
    def extract_text(path: str) -> str:
        return extract_text(path)

    @staticmethod
    def text_to_document_json_dictionary(text: str) -> dict:

        paragraphs = [p.strip() for p in text.strip().split('\n\n') if p.strip()]
        nodes = []
        for paragraph in paragraphs: 
            node = {
                "id": str(uuid.uuid4()),
                "type": "paragraph",
                "text": paragraph,
                "metadata": {}
            }
            nodes.append(node)
        return {"nodes": nodes}
    
    @staticmethod
    def pdf_to_document_json_dictionary(path: str) -> dict:
        return PdfToJsonConverter.text_to_document_json_dictionary(PdfToJsonConverter.extract_text(path))
    
    @staticmethod
    def pdf_to_document_json(path: str) -> str:
        return json.dumps(PdfToJsonConverter.pdf_to_document_json_dictionary(path))

#text = extract_text(test_data_directory / 'Monsters_Test.pdf')
text = PdfToJsonConverter.pdf_to_document_json(test_data_directory / 'Monsters_Test.pdf')

print(text)