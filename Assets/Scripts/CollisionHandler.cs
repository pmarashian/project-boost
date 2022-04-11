using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class CollisionHandler : MonoBehaviour
{
    private void OnCollisionEnter(Collision other)
    {
        switch (other.gameObject.tag)
        {
            case "Finish":
                Debug.Log("You Win!");
                break;

            case "Friendly":
                Debug.Log("Friendly");
                break;

            default:
                Debug.Log("You Lose!");
                break;
        }

    }
}
