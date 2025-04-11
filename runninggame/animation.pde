class Animation
{
  int nFrames = 0;
  PShape[] frames;
  int counter = 0;
  int speed = 5;
  int frameCounter = 0;
  float w = 100;
  float h = 100;
  
  Animation(String[] filenames)
  {
    this.nFrames = filenames.length;
    this.frames = new PShape[this.nFrames];
    for(int i = 0; i < this.nFrames; i = i + 1)
    {
      frames[i]=loadShape(filenames[i]);
    }
  }
  
  void display()
  {
    this.counter = this.counter + 1;
    if(this.counter > this.speed)
    {
      this.counter = 0;
      this.frameCounter = this.frameCounter + 1;
      if(this.frameCounter >= this.nFrames) this.frameCounter=0;
    }
    shape(this.frames[frameCounter],0,0,this.w,this.h);
    
  }
 
}
