interface InGFXobj {
    public dynamic function preUpdate(elapsed:Float);
    public dynamic function postUpdate(elapsed:Float);
    public var __graphic__(get,set):FlxGraphic;

}