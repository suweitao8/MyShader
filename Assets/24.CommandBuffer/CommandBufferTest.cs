//Command Buffer测试
//by: puppet_master
//2017.5.26

using System;
using System.Collections;
using System.Collections.Generic;
using UnityEngine;
using UnityEngine.Rendering;
using UnityEngine.UI;

[ExecuteInEditMode]
public class CommandBufferTest : MonoBehaviour {
    private CommandBuffer commandBuffer = null;
    
    private RenderTexture renderTexture = null;
    
    public GameObject targetObject = null;
    private GameObject _targetObject = null;
    private Renderer targetRenderer = null;

    private void Update()
    {
        if (targetObject != null && targetObject != _targetObject)
        {
            _targetObject = targetObject;
            OnTargetObjectChanged();
        }
    }

    private void OnEnable()
    {
        OnTargetObjectChanged();
    }

    void OnTargetObjectChanged()
    {
        if (targetObject == null) return;
        targetRenderer = targetObject.GetComponent<Renderer>();
        if (targetRenderer == null)
        {
            targetObject = null;
            return;
        }
        
        // 需要创建RendererTexture
        renderTexture = RenderTexture.GetTemporary(512, 512, 16, RenderTextureFormat.ARGB32, RenderTextureReadWrite.Default, 4);
        // 申请一个CommandBuffer
        commandBuffer = new CommandBuffer();
        //设置Command Buffer渲染目标为申请的RT
        commandBuffer.SetRenderTarget(renderTexture);
        //初始颜色设置为灰色
        commandBuffer.ClearRenderTarget(true, true, new Color(0f,0f,0f,0f));
        //绘制目标对象，如果没有替换材质，就用自己的材质
        commandBuffer.DrawRenderer(targetRenderer, targetRenderer.sharedMaterial);
        //然后接受物体的材质使用这张RT作为主纹理
        if (this.GetComponent<Renderer>()) this.GetComponent<Renderer>().material.SetTexture("_RenderTex", renderTexture);
        else this.GetComponent<Image>().material.SetTexture("_RenderTex", renderTexture);
        //直接加入相机的CommandBuffer事件队列中
        Camera.main.AddCommandBuffer(CameraEvent.AfterForwardOpaque, commandBuffer);
    }
 
    void OnDisable()
    {
        if (commandBuffer == null) return;
        //移除事件，清理资源
        Camera.main.RemoveCommandBuffer(CameraEvent.AfterForwardOpaque, commandBuffer);
        commandBuffer.Clear();
        renderTexture.Release();
    }
 
    //也可以在OnPreRender中直接通过Graphics执行Command Buffer，不过OnPreRender和OnPostRender只在挂在相机的脚本上才有作用！！！
    //void OnPreRender()
    //{
    //    //在正式渲染前执行Command Buffer
    //    Graphics.ExecuteCommandBuffer(commandBuffer);
    //}
}