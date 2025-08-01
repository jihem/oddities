/*
      _._ 
    o|- -|o This file is licensed under CC4-BY international license.
     ( l )  To view a copy of this license, visit https://creativecommons.org/licenses/by-sa/4.0/
       =    Author: jean-marc "jihem" quere 2025 - jean-marc.quere@codyssea.com
*/
using System;
using System.Collections.Concurrent;
using System.Threading.Tasks;

class ConsoleWithThreads
{
    static readonly BlockingCollection<Action> Actions = new BlockingCollection<Action>();
    static async Task RunBackgroundTask(int n)
    {
        for (var i = 0; i < 15; i += n)
        {
            var msg = $"Async background task ({n}) running : {i}.";
            Actions.Add(() =>
            {
                Log(msg);
            });
            await Task.Delay(1000);
        }
    }

    static async Task ManageTask()
    {
        var tasks=new List<Task>();
        for (var i = 1; i < 4; i++)
        {
            tasks.Add(RunBackgroundTask(i));
        }
        await Task.WhenAll(tasks);
    }

    static void Log(string message)
    {
        Console.WriteLine($"{Environment.CurrentManagedThreadId} -> {message}");
    }
    
    static void Main()
    {
        Console.WriteLine($"Main thread ({Environment.CurrentManagedThreadId}) started");
        var awaiter=ManageTask().GetAwaiter();

        while (!awaiter.IsCompleted)
        {
            if (Actions.TryTake(out var action, TimeSpan.FromMilliseconds(100)))
            {
                action();
            }
            else
            {
                Task.Delay(1000);
            }
        }
        Console.WriteLine("Main thread finished.");
    }
}