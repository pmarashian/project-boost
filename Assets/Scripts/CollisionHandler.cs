using UnityEngine;
using UnityEngine.SceneManagement;

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
                ReloadLeve();
                break;
        }

    }

    private void ReloadLeve()
    {
        string currentSceneName = SceneManager.GetActiveScene().name;
        SceneManager.LoadScene(currentSceneName);
    }
}
