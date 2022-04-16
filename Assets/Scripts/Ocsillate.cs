using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class Ocsillate : MonoBehaviour
{

    Vector3 pos;
    Vector3 Movement = new Vector3(10f, 0, 0);
    [SerializeField] [Range(-1,1)] float movementFactor = 0;
    [SerializeField] [Range(0f,2f)] float period = 1f;

    // Start is called before the first frame update
    void Start()
    {
        pos = transform.position;
    }

    // Update is called once per frame
    void Update()
    {

        if (period <= Mathf.Epsilon) { return; }

        float cyles = Time.time / period;
        // multiply the movement factor by the time and sin
        movementFactor = Mathf.Sin( cyles );
        gameObject.transform.position = pos + Movement * movementFactor;
    }
}
