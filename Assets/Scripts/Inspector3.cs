using System;
using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class Inspector3 : Inspector
{
    [Header("Setup - Please don't touch :)")]
    public GameObject[] pdMesh;
    public GameObject[] idMesh;
    public Camera renderCamera;
    public RenderTexture renderTexture;
    
    [Serializable]
    public enum Poly
    {
        TwoHundred,
        EightHundred,
        ThousandEightHundred
    }
    
    [Header("Choose a number of polygons for the meshes")]
    public Poly PolygonsInMesh;

    [Header("Pre-distortion settings")]
    public float pdC1 = -0.14f;
    public float pdC2 = 0.04f;

    [Header("Inverse distortion settings")]
    public bool doInverse = true;
    public float idC1 = -0.33f;
    public float idC2 = 0.1f;
    
    private Material idMat;
    private Material pdMat;
    private static readonly int _C1 = Shader.PropertyToID("_c1");
    private static readonly int _C2 = Shader.PropertyToID("_c2");
    private void Start()
    {
        renderCamera.targetTexture = !doInverse ? null : renderTexture;
                
        foreach (var pd in pdMesh)
        {
            pd.SetActive(false);
        }
        
        foreach (var id in idMesh)
        {
            id.SetActive(false);
        }
        
        switch (PolygonsInMesh)
        {
            case Poly.TwoHundred:
                pdMesh[0].SetActive(true);
                pdMat = pdMesh[0].GetComponent<Renderer>().material;
                idMesh[0].SetActive(true);
                idMat = idMesh[0].GetComponent<Renderer>().material;
                break;
            case Poly.EightHundred:
                pdMesh[1].SetActive(true);
                pdMat = pdMesh[1].GetComponent<Renderer>().material;
                idMesh[1].SetActive(true);
                idMat = idMesh[1].GetComponent<Renderer>().material;
                break;
            case Poly.ThousandEightHundred:
                pdMesh[2].SetActive(true);
                pdMat = pdMesh[2].GetComponent<Renderer>().material;
                idMesh[2].SetActive(true);
                idMat = idMesh[2].GetComponent<Renderer>().material;
                break;
            default:
                throw new ArgumentOutOfRangeException();
        }

        
        pdMat.SetFloat(_C1, pdC1);
        pdMat.SetFloat(_C2, pdC2);
        
        idMat.SetFloat(_C1, idC1);
        idMat.SetFloat(_C2, idC2);
    }
}
