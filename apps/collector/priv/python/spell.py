from spellchecker import SpellChecker

spell = SpellChecker(distance=1)
def spell_error(chunk):
    words = spell.unknown(chunk)
    return words

