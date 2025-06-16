from pdfminer.high_level import extract_text
from pathlib import Path

backend_dir = Path(__file__).resolve().parent
test_data_directory = backend_dir.parent / 'test_data'

text = extract_text(test_data_directory / 'Monsters_Test.pdf')

print(text)