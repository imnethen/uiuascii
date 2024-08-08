# Experimental!

---Gaussian
  # (1.0f / sqrt(tau * sigma^2)) * exp(-(pos^2) / (2.0f * sigma^2))
  F ↚ ×⊓(¨÷1√×τ|¨ⁿe÷¯×2).∩°√
  
  GaussianKernel ↚ ¤÷⊸/+≡¨F-2⇡5 ↯5
  
  HorizontalPass ↚ (
    ⍜(☇1|≡/+×)⬚0◫1_5
    ≡(↘¯2↘2♭)
  )
  
  VerticalPass ↚ (
    ⍜(☇2|≡/+×≡♭)⬚0◫5_1
    ↘¯2↘2
  )
  
  Blur ← (
    :GaussianKernel
    ⊸HorizontalPass
    VerticalPass
  )
---

---Sobel
  HGx ↚ ¤¯3_0_3
  HGy ↚ ¤1_10_3
  VGx ↚ ¤3_10_3
  VGy ↚ ¤3_0_¯3
  
  HorizontalPass ↚ (
    .≡(↘¯1↘1) ⬚0◫1_3
    ⍜(∩(☇2)|∩(≡/+×)HGx:HGy∩≡♭)
  )
  VerticalPass ↚ (
    ∩(↘¯1↘1 ⬚0◫3_1)
    ⍜(∩(☇2)|∩(≡/+×)VGx:VGy∩≡♭)
  )
  Sobel ← (
    HorizontalPass
    :VerticalPass
  )
  Mag ← ⍜°√/+⊟
  Ang ← ÷τ+π∠
---

---Ascii
  # downscale factor
  # each character corresponds to a CharSize x CharSize
  # square of the original image
  # 
  # its probably better to move this to the top of the file but i dont wanna move the whole ascii module there and i also dont wanna move this out of the module so idk
  CharSize ← 4
  
  # normalizes an image (rank 2 array) so max element is 1
  Norm ← ÷⊸(/↥♭)
  # blends between 2 arrays based on a mask
  Blend ← ≡⍜▽(◌⊙▽)⟜:
  
  EdgeThreshold ↚ CharSize
  
  # edge chars used for sampling
  # (can just use the angle as an index into these)
  EdgeCharsSample ↚ $ |\\__//||\\__//|
  EdgeChars ↚ " |_/\\"
  Chars ↚ " .;+?O@"
  AllChars ↚ ⊂Chars EdgeChars
  
  AllCharsImg ↚ (
    ∩(◌°imen &frab)"resources/chars.png" "resources/edgechars.png"
    ∩(⊢°⍉)
    ∩(°¤chunks8_8)
    ⊂
  )
  
  ImageToLum ← /+×0.3_0.59_0.11
  LumToChars ← ¨⊏Chars⌊×⧻Chars
  AnglesToEdges ← ¨⊏EdgeCharsSample⌊×⧻EdgeCharsSample-0.0001
  
  LumToEdges ← (
    # this is the difference of gaussians
    >0.005-∩Gaussian~Blur3.2,2
    Sobel~Sobel
    ⊃(>0.1Norm Sobel~Mag|¨↯@ △|AnglesToEdges Sobel~Ang)
    Blend
    chunks⊟.CharSize
    ≡≡(-1⊕⧻⊸⊛⊂EdgeChars♭)
    ≡≡(¨⊡EdgeChars⊗×⊸>EdgeThreshold⊸/↥ ⍜⊢(0◌))
  )
  
  CharsToImg ← (
    ∵(¨⊗AllChars)
    ¨⊏AllCharsImg
  )
---

⨬(◌°imen&frab⊡1&args|Lena)<2⧻&args

⍜(⍉☇1|Ascii~ImageToLum↙3)

⟜Ascii~LumToEdges
chunks⊟.Ascii~CharSize
≡≡(÷⧻⟜/+♭)
Ascii~LumToChars
⊸=" ":
Ascii~Blend

Ascii~CharsToImg
/⊂≡(⇌⍉/⊂≡(≡⇌⍉))
⨬(&fwa⊡2&argsimen"png"|&ims)<3⧻&args
