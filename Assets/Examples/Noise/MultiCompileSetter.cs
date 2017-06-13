using System.Collections;
using System.Collections.Generic;
using UnityEngine;

[ExecuteInEditMode]
public class MultiCompileSetter : MonoBehaviour {
    [SerializeField]
    Material targetMat;

    [SerializeField]
    int selection;
    [SerializeField]
    string[] keywords;

	void Update () {
        targetMat.shaderKeywords = null;
        if (keywords != null && 0 <= selection && selection < keywords.Length) {
            targetMat.EnableKeyword (keywords [selection]);
        }
    }
}
