using UnityEngine;
using UnityEngine.Rendering;
using UnityEngine.Rendering.HighDefinition;
using System;

[Serializable, VolumeComponentMenu("Post-processing/Custom/SceneSwitch")]
public sealed class SceneSwitch : CustomPostProcessVolumeComponent, IPostProcessComponent
{
    public ClampedFloatParameter scale = new ClampedFloatParameter(1f, 0f, 1f);
    public ClampedFloatParameter width = new ClampedFloatParameter(0.267f, 0f, 1f);
    public ClampedFloatParameter height = new ClampedFloatParameter(0.483f, 0f, 1f);
    public Vector4Parameter viewport = new Vector4Parameter(new Vector4(0.5f, 0.5f, 0, 0));

    Material m_Material;

    public bool IsActive() => m_Material != null && scale.value >= 0f;

    public override CustomPostProcessInjectionPoint injectionPoint => CustomPostProcessInjectionPoint.AfterPostProcess;

    public override void Setup()
    {
        string shaderName = "Hidden/Shader/SceneSwitch";

        if (Shader.Find(shaderName) != null)

            m_Material = new Material(Shader.Find(shaderName));
    }

    public override void Render(CommandBuffer cmd, HDCamera camera, RTHandle source, RTHandle destination)
    {
        if (m_Material == null)

            return;

        m_Material.SetVector("_Viewport", viewport.value);
        m_Material.SetFloat("_Width", width.value);
        m_Material.SetFloat("_Height", height.value);

        m_Material.SetFloat("_Scale", scale.value);

        m_Material.SetTexture("_Albedo", source);

        HDUtils.DrawFullScreen(cmd, m_Material, destination);
    }

    public override void Cleanup() => CoreUtils.Destroy(m_Material);
}