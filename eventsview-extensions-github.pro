TEMPLATE = aux
QT =

eventfeed.files = eventfeed
eventfeed.path =  $$PREFIX/share/lipstick
INSTALLS += eventfeed

OTHER_FILES += $$files(rpm/*)
