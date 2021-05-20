using System;
using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class Inspector2 : Inspector
{
    [Header("Setup - Please don't touch :)")]
    public GameObject projectionQuad;
    
    [Header("Red")]
    [Header("Inverse Aberration settings")]
    public float c1R = -0.5f;
    public float c2R = 0f;
    [Header("Green")]
    public float c1G = 0f;
    public float c2G = 0f;
    [Header("Blue")]
    public float c1B = 0.5f;
    public float c2B = 0f;


    private Material projectionMat;
    private static readonly int _c1R = Shader.PropertyToID("_c1R");
    private static readonly int _c2R = Shader.PropertyToID("_c2R");
    private static readonly int _c1G = Shader.PropertyToID("_c1G");
    private static readonly int _c2G = Shader.PropertyToID("_c2G");
    private static readonly int _c1B = Shader.PropertyToID("_c1B");
    private static readonly int _c2B = Shader.PropertyToID("_c2B");
    private void Awake()
    {
        projectionMat = projectionQuad.GetComponent<Renderer>().material;
        projectionMat.SetFloat(_c1R, c1R);
        projectionMat.SetFloat(_c2R, c2R);
        projectionMat.SetFloat(_c1G, c1G);
        projectionMat.SetFloat(_c2G, c2G);
        projectionMat.SetFloat(_c1B, c1B);
        projectionMat.SetFloat(_c2B, c2B);
    }
}
