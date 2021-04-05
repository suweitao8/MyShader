using System;
using System.IO;
using UnityEngine;

public class BlitToTex : MonoBehaviour
{
    public RenderTexture Rt;
    public Material Mat;
    void Update()
    {
        if (Input.GetKeyDown(KeyCode.Space))
        {
            if (Rt == null || Mat == null) return;
            var newTex = new Texture2D(128, 128);
            Graphics.Blit(newTex, Rt, Mat);
            Graphics.CopyTexture(Rt, 0, 0, 0, 0, 128, 128, newTex, 0, 0, 0, 0);
            newTex.Apply(false, false);
            newTex.ReadPixels(new Rect(0, 0, 128, 128), 0, 0);
            var dir = "Assets/Textures/PerlinNoiseTex";
            if (Directory.Exists(dir)) Directory.CreateDirectory(dir);
            var file = $"{dir}/{DateTime.Now.Ticks}_outTex.jpg";
            File.WriteAllBytes(file, newTex.EncodeToJPG());
            Debug.Log($"out put tex2d success:{file}");
        }
    }
}
