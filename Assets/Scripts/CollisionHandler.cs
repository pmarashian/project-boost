using UnityEngine;
using UnityEngine.SceneManagement;

public class CollisionHandler : MonoBehaviour
{
    private void OnCollisionEnter(Collision other)
    {
        switch (other.gameObject.tag)
        {
            case "Finish":
                Debug.Log("You win!");
                LoadNextLeve();
                break;

            case "Friendly":
                Debug.Log("Friendly");
                break;

            default:
                StartCrashSequence();
                break;
        }

    }

    private void StartCrashSequence()
    {
        Debug.Log("You lose!");
        gameObject.GetComponent<Movement>().enabled = false;
        Invoke("ReloadLevel", 2f);
    }

    private void LoadNextLeve()
    {

        // get total number of scenes
        int totalScenes = SceneManager.sceneCountInBuildSettings;

        // if current scene is last scene, load first scene
        int currentSceneIndex = SceneManager.GetActiveScene().buildIndex;
        if (currentSceneIndex == totalScenes - 1)
        {
            SceneManager.LoadScene(0);
        }
        else
        {
            // load next scene
            SceneManager.LoadScene(currentSceneIndex + 1);
        }

    }


    private void ReloadLevel()
    {
        string currentSceneName = SceneManager.GetActiveScene().name;
        SceneManager.LoadScene(currentSceneName);
    }
}
