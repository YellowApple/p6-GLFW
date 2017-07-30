unit class Image is repr('CStruct');

has int32 $.width;
has int32 $.height;
has CArray[uint8] $.pixels;
